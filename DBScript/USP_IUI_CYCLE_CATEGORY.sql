drop PROCEDURE USP_IUI_CYCLE_CATEGORY  
Go
-- USP_IUI_CYCLE_CATEGORY_v1 64, 1, 2023 
------------------------------------ 
-- crated by : guru singh 
-- crated date: 15-mar-2023 
------------------------------------ 
CREATE PROCEDURE USP_IUI_CYCLE_CATEGORY  
( 
    @empId int = null, 
    @month int = NULL, 
    @Year int = null 
) 
AS   
    set nocount on; 
        BEGIN 
        if @month is NULL 
            BEGIN 
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) 
            END 
        if @Year is NULL 
            BEGIN 
            set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) 
            END 
CREATE TABLE #empHierarchy  
(  
    levels smallInt,  
    EmpID INT,  
    ParentId int  
)  
;WITH  
    RecursiveCte  
    AS  
    (  
        SELECT 1 as Level, H1.EmpID, H1.ParentId  
            FROM tblHierarchy H1  
            WHERE (@empid is null or ParentID = @empid)  
        UNION ALL  
        SELECT RCTE.level + 1 as Level, H2.EmpID, H2.ParentId  
            FROM tblHierarchy H2  
                INNER JOIN RecursiveCte RCTE ON H2.ParentId = RCTE.EmpID  
    )  
            insert into #empHierarchy  
                (levels, EmpID, ParentId )  
            SELECT Level, EmpID, ParentId  
            FROM RecursiveCte r  
            ;  
             insert into #empHierarchy  
                (levels, EmpID, ParentId )  
            VALUEs (0, @empId, -1) 
        declare @addedFor DATE 
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))  
        select case 
                when IUICycle = 0 then 'Nill to Zero Cycle' 
                WHEN IUICycle BETWEEN 1 AND 10 THEN '1 to 10 Cycle' 
                WHEN IUICycle BETWEEN 11 AND 20 THEN '11 to 20 Cycle' 
                WHEN IUICycle BETWEEN 21 AND 30 THEN '21 to 30 Cycle' 
                WHEN IUICycle BETWEEN 31 AND 40 THEN '31 to 40 Cycle' 
                else 'F - more then 40 Cycle' 
            end as Cycle, 
			case 
                when IUICycle = 0 then 0 
                WHEN IUICycle BETWEEN 1 AND 10 THEN 1 
                WHEN IUICycle BETWEEN 11 AND 20 THEN 2 
                WHEN IUICycle BETWEEN 21 AND 30 THEN 3 
                WHEN IUICycle BETWEEN 31 AND 40 THEN 4 
                else 5 
            end as CycleSort, 
			 hospitalId 
        from tblhospitalsPotentials 
        where PotentialEnteredFor = @addedFor 
        and empId in (select empId from #empHierarchy) 
		order by CycleSort asc 
          drop table #empHierarchy  
        END 
    set nocount off; 
 
 