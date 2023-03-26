DROP PROCEDURE USP_REPORT_BRANDS_ANALYSIS   
GO
-- USP_REPORT_BRANDS_ANALYSIS null, NULL, NULL
------------------------------------   
-- crated by : guru singh   
-- crated date: 15-mar-2023   
------------------------------------   
CREATE PROCEDURE USP_REPORT_BRANDS_ANALYSIS   
(   
    @empId int = null,  
    @fromDate date = null,
    @toDate date  = null
)   
AS     
set nocount on;     
    BEGIN
        IF @fromDate IS NULL    
        BEGIN
            SET @fromDate = '1-JAN-2023'
        END
        IF @toDate IS NULL    
        BEGIN
            SET @toDate = '31-DEC-2029'
        END


            CREATE TABLE #empHierarchy (levels smallInt, EmpID INT, ParentId int )
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

            -- select count(*) from #empHierarchy  

            -- USP_REPORT_BRANDS_ANALYSIS null, '1-jan-2023', '31-Mar-2023'
            select ha.brandId, sg.groupname as name,  sum(qty) as sumTotalofQty
            -- count(*) as CNT
            from TblHospitalactuals ha  
            INNER JOIN tblBrandGroups sg on sg.brandGroupId = ha.brandGroupId  
            where ha.isApproved = 0  and ha.isDisabled = 0  
            and empId in (select empId from #empHierarchy)   
            and (ActualEnteredFor BETWEEN @fromDate AND @toDate)
            GROUP BY ha.brandId, ha.brandGroupId, sg.groupname 
            order by ha.brandId asc



            select ca.brandId, bcs.name, sum(businessValue) as TotalBusinessValue from tblCompetitions ca 
            inner join tblbrandCompetitorSkus bcs 
                on bcs.brandId = ca.brandId and bcs.competitorId = ca.CompetitionSkuId
            where ca.isApproved = 0  -- and ca.brandId  in (1) and bcs.competitorId in (2, 4, 19)
            and empId in (select empId from #empHierarchy)   
            and (competitionAddedFor BETWEEN @fromDate AND @toDate)
            GROUP by ca.brandId, bcs.name
            order by ca.brandId asc    

         
        

            drop table #empHierarchy    
    END   
set nocount off;   

-- select * from tblBrandGroups where brandId = 6
-- select * from tblBrandcompetitorSKUs where brandId = 6
