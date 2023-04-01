drop PROCEDURE USP_REPORT_BRANDS_CONSUMPTION
go
-- USP_REPORT_BRANDS_CONSUMPTION null, NULL, NULL 
------------------------------------    
-- crated by : guru singh    
-- crated date: 15-mar-2023    
------------------------------------    
CREATE PROCEDURE USP_REPORT_BRANDS_CONSUMPTION
(    
    -- @empId int = null,   
    -- @fromDate date = null, 
    -- @toDate date  = null 

     @empId int = null, 
     @month int = NULL, 
    @Year int = null 
)    
AS      
set nocount on;      
    BEGIN 
        -- IF @fromDate IS NULL     
        -- BEGIN 
        --     SET @fromDate = '1-JAN-2023' 
        -- END 
        -- IF @toDate IS NULL     
        -- BEGIN 
        --     SET @toDate = '31-DEC-2023' 
        -- END 
   
         if @month is NULL 
             BEGIN 
            set @month =  month(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) 
             END 
        if @Year is NULL 
 
            BEGIN 
             set @Year =  year(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) 
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
 



 declare @addedFor DATE 
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))  
    SELECT  
        bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,    
        bsv_ivf.getMyRBMInfo(e.empid) AS RBM,    
        e.firstName as KamName, e.Designation,     
        c.CENTRENAME as centreName,  c.DoctorName,  
        HP.IVFCycle as 'IVF Fresh stimulated Cycles'
        --, hp.hospitalId,
        --c.customerId
        , c.CENTRENAME, c.DoctorName,
         hp.empId
        ,(HP.IVFCycle * 10) as 'Foligraf'
        ,(HP.IVFCycle * 10) as 'Humog'
        ,(HP.IVFCycle * 5) as 'Asporelix'
        ,(HP.IVFCycle * 1) as 'R-Hucog'
        ,(HP.IVFCycle * 1) as 'Agotrig'
        ,(HP.IVFCycle * 30) as 'Midydrogen'
        FROM TblHospitalsPotentials hp
        INNER join tblCustomers c on c.customerID = hp.hospitalId
        INNER join tblEmployees e on e.empId = hp.empId
        WHERE  hp.isActive = 0 
        and  hp.isApproved = 0
       --  and (PotentialEnteredFor BETWEEN @fromDate AND @toDate) 
        and PotentialEnteredFor = @addedFor 
        and hp.empId in (select empId from #empHierarchy)   
         order by hospitalId ASC 
      
      
         
            drop table #empHierarchy     
    END    
set nocount off;    
    
 
--    SELECT * FROM TBLEMPLOYEES WHERE DESIGNATION = 'ADMIN'