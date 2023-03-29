DROP PROCEDURE USP_REPORT_MARKET_INSIGHT   
GO
-- USP_REPORT_MARKET_INSIGHT null, 1, 2023   
------------------------------------   
-- crated by : guru singh   
-- crated date: 15-mar-2023   
------------------------------------   
CREATE PROCEDURE USP_REPORT_MARKET_INSIGHT   
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
   
  
    -- SELECT count(*) from #empHierarchy  
  
        declare @addedFor DATE   
        set  @addedFor = (DATEFROMPARTS (@Year, @Month, 1))    
        
  
   
            SELECT  
                SUM(TRY_CAST(answerFourRHCG AS INT)) as RHCG,  
                SUM(TRY_CAST(answerFourUHCG AS INT)) as UHCG,  
                SUM(TRY_CAST(answerFourAgonistL AS INT)) as AgonistL,  
                SUM(TRY_CAST(answerFourAgonistT AS INT)) as AgonistT,  
                SUM(TRY_CAST(answerFourRHCGTriptorelin AS INT)) as RHCGTriptorelin,  
                SUM(TRY_CAST(answerFourRHCGLeuprolide AS INT)) as RHCGLeuprolide 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
 
 
             
            SELECT  
                SUM(TRY_CAST(answerProgesterone AS INT)) as Progesterone, 
                SUM(TRY_CAST(answerFiveDydrogesterone AS INT)) as Dydrogesterone, 
                SUM(TRY_CAST(answerFiveCombination AS INT)) as Combination 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
 
 
 
            SELECT  
               SUM(TRY_CAST(answerThreeHMG AS INT)) as [R-FSH], 
                SUM(TRY_CAST(answerThreeRFSH AS INT)) as HMG 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
  
   
 
            SELECT  
                COUNT(CASE WHEN answerOne = 0 THEN 1 END) AS Yes_obstetrics, 
                COUNT(CASE WHEN answerOne = 1 THEN 1 END) AS NO_obstetrics 
            FROM tblMarketInsights 
            WHERE  addedFor = @addedFor  -- 1388 
            AND isApproved = 0 -- 1025 
            AND isActive = 0 -- 991 
            AND empId IN (SELECT empId FROM #empHierarchy)   
 
 
    
   
    SELECT  
 HP.IVFCycle , 
TRY_CAST(answerThreeRFSH AS DECIMAL(5, 2) ) AS answerThreeRFSH, 
TRY_CAST(IVFCycle * (TRY_CAST(answerThreeRFSH AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [RFS CONSUMPTION] , 
--ROUND(TRY_CAST(IVFCycle * (TRY_CAST(answerThreeRFSH AS DECIMAL )/100) AS DECIMAL(5, 2)), 0) AS [RFS CONSUMPTION ROUNDOFF] , 
  
TRY_CAST(answerThreeHMG AS DECIMAL ) AS answerThreeHMG  ,
TRY_CAST(IVFCycle * (TRY_CAST(answerThreeHMG AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [HMG CONSUMPTION] , 
-- ROUND(TRY_CAST(IVFCycle * (TRY_CAST(answerThreeHMG AS DECIMAL )/100) AS DECIMAL(5, 2)), 0) AS [HMG CONSUMPTION ROUNDOFF] 

MI.answerProgesterone,
TRY_CAST(IVFCycle * (TRY_CAST(answerProgesterone AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Progesterone CONSUMPTION],

MI.answerFiveDydrogesterone,
TRY_CAST(IVFCycle * (TRY_CAST(answerFiveDydrogesterone AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Dydrogesterone CONSUMPTION],

MI.answerFiveCombination,
TRY_CAST(IVFCycle * (TRY_CAST(answerFiveCombination AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Progesretone+Dydrogesterone CONSUMPTION],

answerFourRHCG,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourRHCG AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [R-HCG CONSUMPTION],
answerFourUHCG,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourUHCG AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [U-HCG CONSUMPTION],
answerFourAgonistL,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourAgonistL AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Only Agonist-Leuprolide CONSUMPTION],
answerFourAgonistT,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourAgonistT AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Only Agonist-Triptorelin CONSUMPTION],
answerFourRHCGTriptorelin,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourRHCGTriptorelin AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Dual Trigger (R-HCG + Triptorelin) CONSUMPTION],
answerFourRHCGLeuprolide,
TRY_CAST(IVFCycle * (TRY_CAST(answerFourRHCGLeuprolide AS DECIMAL )/100) AS DECIMAL(5, 2)) AS [Dual Trigger (R-HCG + Leuprolide) CONSUMPTION]




        FROM tblMarketInsights MI
        INNER JOIN TblHospitalsPotentials HP ON HP.HOSPITALID = MI.CENTREID
        WHERE  
        MI.addedFor = @addedFor 
        AND HP.PotentialEnteredFor = @addedFor  
        AND MI.isApproved = 0  
        AND MI.isActive = 0 
        AND MI.empId IN (SELECT empId FROM #empHierarchy) 

        
 
          drop table #empHierarchy    
        END   
    set nocount off;   
   