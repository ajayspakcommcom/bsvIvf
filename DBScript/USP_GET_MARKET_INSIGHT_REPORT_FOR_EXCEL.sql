drop PROCEDURE USP_GET_MARKET_INSIGHT_REPORT_FOR_EXCEL  
go
-- USP_GET_MARKET_INSIGHT_REPORT_FOR_EXCEL 1, 2023   
CREATE PROCEDURE USP_GET_MARKET_INSIGHT_REPORT_FOR_EXCEL      
    (   
        @month int,   
        @year int   
    )   
AS     
    BEGIN     
    declare @dateAddedFor smallDateTime       
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))     
    
select      
    bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,       
    bsv_ivf.getMyRBMInfo(e.empid) AS RBM,       
    -- e.empid,        
    e.firstName as KamName, e.Designation,        
    -- c.customerId,        
    c.CENTRENAME as centreName,  c.DoctorName,       
    c.customerId,        
    case      
    when hp.answerone = 1 then 'Yes'     
    else 'No'     
    end as 'Practice Obstetrics',     
    (  
        select top 1 ivfcycle from TblHospitalsPotentials where HOSPITALID = c.customerId  and PotentialEnteredFor = @dateAddedFor and isActive = 0   
    ) as 'Fresh Stimulated Cycles',  
    -- hp.AnswerTwo as 'Fresh Stimulated Cycles',     
    -- hpp.IVFCycle as 'Fresh Stimulated Cycles',     
    hp.answerThreeRFSH as 'RFSH %',     
    hp.answerThreeHMG as 'HMG %',     
    hp.answerProgesterone as 'Progesterone %',     
    hp.answerFiveDydrogesterone as 'Dydrogesterone %',     
    hp.answerFiveCombination as 'Combination %',     
    hp.answerFourRHCG as 'RHCG %',     
    hp.answerFourUHCG as 'UHCG %',     
    hp.answerFourAgonistL as 'Agonist-Leuprolide %',     
    hp.answerFourAgonistT as 'Agonist-Triptorelin %',     
    hp.answerFourRHCGTriptorelin as 'Dual Trigger (R-HCG + Triptorelin) %',     
    hp.answerFourRHCGLeuprolide as 'Dual Trigger (R-HCG + Leuprolide) %',     
    case HP.isApproved           
        when 1 then 'Pending'           
        when 0 then 'Approved'           
        when 2 then 'Rejected'           
    end as statusText,           
    bsv_ivf.getEMPInfo(hp.approvedBy) AS ApprovedBy,      
    isNull(hp.approvedOn, '') as ApprovedOn,      
    bsv_ivf.getEMPInfo(hp.rejectedBy) AS RejectedBy,      
    hp.rejectedOn, hp.rejectComments, addedFor     
    from tblMarketInsights HP           
    INNER JOIN tblCustomers C ON C.CustomerID = hp.centreId    
     -- INNER JOIN TblHospitalsPotentials HPp ON HpP.HOSPITALID = hp.CENTREID  and PotentialEnteredFor = @dateAddedFor and hpp.isActive = 0   
    left outer JOIN tblAccount a on a.accountID = c.accountID        
    INNER join tblEmployees e on e.empid = hp.empId        
    where 1 = 1        
    and hp.isActive = 0    
    and addedFor = @dateAddedFor           
    --  and addedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)            
    order by e.firstName ASC     
       END    
   