DROP PROCEDURE USP_VALIDATE_TEAM_PROGRESS_REPORT
GO
-- USP_VALIDATE_TEAM_PROGRESS_REPORT  826, 1, 2023
 -----------------------------------------
 -- CREATED BY: GURU SINGH
 -- CREATED DATE: 2-APR-2023
 -----------------------------------------
 CREATE PROCEDURE USP_VALIDATE_TEAM_PROGRESS_REPORT
 (
      @empId int = null,   
    @month int = NULL,   
    @Year int = null  
 )
 AS     
    -- SET NOCOUNT ON;   
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
   
  
            -- SELECT count(*) from #empHierarchy  
  
            declare @addedFor DATE   
            set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1)) 

            select e.empid,
            bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,   bsv_ivf.getMyRBMInfo(e.empid) AS RBM,    e.FIRSTname, e.designation, 
            (select count(*) from tblcustomers c
            inner join tblemphospitals eh on c.customerId = eh.hospitalId
            where empID = e.empid and isdisabled = 0 and SpecialtyId in (2)) as TotalIVFCount 
            from tblemployees e where 
            1 = 1
            and isdisabled = 0 
            AND empId IN (SELECT empId FROM #empHierarchy)  
        --  and e.EmpID = @empid or @empid is null
            and designationid in (3)
            ORDER BY e.FIRSTname  

            -- USP_VALIDATE_TEAM_PROGRESS_REPORT  61

            select eh.empID, c.customerId, c.CENTRENAME, c.DoctorName, 
                case 
                when hp.potentialenteredfor is null then 'NO'
                else 'YES' 
                end as PotentialedEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join TblHospitalsPotentials hp on hp.hospitalID = c.customerId and hp.potentialenteredfor = @addedFor
            where c.SpecialtyId in (2)
           --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            order by customerId ASC


            select 
             eh.empID, c.customerId, c.CENTRENAME, c.DoctorName
                , case 
                when ha.actualEnteredFor is null then 'NO'
                else 'YES' 
                end as BusinessdEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join tblhospitalactuals ha on ha.hospitalID = c.customerId and ha.actualEnteredFor = @addedFor
            where c.SpecialtyId in (2)
            --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            group by eh.empID, c.customerId, c.CENTRENAME, c.DoctorName, actualEnteredFor
            order by c.customerId ASC
            -- USP_VALIDATE_TEAM_PROGRESS_REPORT  811


            select 
             eh.empID, c.customerId, c.CENTRENAME, c.DoctorName
                , case 
                when ha.addedfor is null then 'NO'
                else 'YES' 
                end as MarketInsightdEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join tblMarketInsights ha on ha.centreId = c.customerId and ha.addedfor = @addedFor
            where c.SpecialtyId in (2)
            --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            order by c.customerId ASC

        -- USP_VALIDATE_TEAM_PROGRESS_REPORT  811

            select 
             eh.empID, c.customerId, c.CENTRENAME, c.DoctorName
                , case 
                when ha.competitionAddedFor is null then 'NO'
                else 'YES' 
                end as CompEntered
                from tblCustomers c 
            inner join tblEmpHospitals eh on eh.hospitalID = c.customerId 
            left  join tblCompetitions ha on ha.centerId = c.customerId and ha.competitionAddedFor = @addedFor
            where c.SpecialtyId in (2)
            --  and eh.EmpID = @empid or @empid is null
            AND eh.EmpID IN (SELECT empId FROM #empHierarchy) 
            group by eh.empID, c.customerId, c.CENTRENAME, c.DoctorName, competitionAddedFor
            order by c.customerId ASC



        END
    --SET NOCOUNT OFF;  

 