drop PROCEDURE USP_GET_POTENTIAL_REPORT_FOR_EXCEL  
go
CREATE PROCEDURE USP_GET_POTENTIAL_REPORT_FOR_EXCEL     
(  
    @month int,  
    @year int  
)  
   
as     
   
begin     
     declare @dateAddedFor smallDateTime      
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))    
     
   
    select      
   
bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,     
   
bsv_ivf.getMyRBMInfo(e.empid) AS RBM,     
   
-- e.empid,      
   
e.firstName as KamName, e.Designation,      
   
     
   
c.CENTRENAME as centreName,  c.DoctorName,    
c.customerId,   
   
hp.IUICycle, IVFCycle, hp.FreshPickUps, hp.SelftCycle, hp.DonorCycles, hp.AgonistCycles, hp.frozenTransfers, hp.Antagonistcycles,     
   
hp.isApproved,      
   
bsv_ivf.getEMPInfo(hp.approvedBy) AS ApprovedBy,     
   
isNull(hp.approvedOn, '') as ApprovedOn,     
   
bsv_ivf.getEMPInfo(hp.rejectedBy) AS RejectedBy,     
   
hp.rejectedOn, hp.rejectComments, hp.PotentialEnteredFor,      
   
-- hp.visitId,     
   
 vt.name as visiType,     
   
     
   
case HP.isApproved                          
   
    when 1 then 'Pending'                          
   
    when 0 then 'Approved'                          
   
    when 2 then 'Rejected'                      
   
end as RBMStaus     
   
from tblEmployees e     
   
inner join TblHospitalsPotentials hp on hp.empId = e.EmpID     
   
inner join tblcustomers c on c.customerID = hp.hospitalId     
   
INNER join tblVisitType vt on vt.visitId = hp.visitID     
   
where  1 = 1     
   
 and hp.PotentialEnteredFor = @dateAddedFor       
   
-- and hp.PotentialEnteredFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)       
   
-- and e.EmpID = 63     
   
and hp.isactive = 0     
   
and e.isdisabled = 0      
   
order by e.firstName ASC      
-- order by c.CENTRENAME,  c.DoctorName, c.customerId ASC 
   
     
   
end 