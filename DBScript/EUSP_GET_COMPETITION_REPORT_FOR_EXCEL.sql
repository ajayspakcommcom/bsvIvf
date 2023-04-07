drop PROCEDURE EUSP_GET_COMPETITION_REPORT_FOR_EXCEL  
go
CREATE PROCEDURE EUSP_GET_COMPETITION_REPORT_FOR_EXCEL    
(  
    @month int,  
    @year int  
)  
 AS    
 BEGIN    
   
     declare @dateAddedFor smallDateTime      
    set  @dateAddedFor = (DATEFROMPARTS (@Year, @Month, 1))    
   
select bsv_ivf.getMyZBMInfo(e.empid) AS ZBM,     
   
bsv_ivf.getMyRBMInfo(e.empid) AS RBM,     
   
-- e.empid,      
   
e.firstName as KamName, e.Designation,      
   
 
   
c.CENTRENAME as centreName,  c.DoctorName,  
com.centerId as centerId,         
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 1, @month, @year) as 'FOLIGRAF',    
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 2, @month, @year) as 'HUMOG',    
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 3, @month, @year) as 'ASPORELIX',    
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 4, @month, @year) as 'R-HUCOG',    
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 5, @month, @year) as 'FOLICULIN',    
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 6, @month, @year) as 'AGOTRIG',    
   
    bsv_ivf.getCompetationTotalforHospitalAndBrand(centerId, 7, @month, @year) as 'MIDYDROGEN',    
   
     case com.isApproved                         
   
                    when 1 then 'Pending'                         
   
                    when 0 then 'Approved'                         
   
                    when 2 then 'Rejected'                     
   
                end as statusText,     
   
bsv_ivf.getEMPInfo(com.approvedBy) AS ApprovedBy,     
   
isNull(com.approvedOn, '') as ApprovedOn,     
   
bsv_ivf.getEMPInfo(com.rejectedBy) AS RejectedBy,     
   
 com.rejectedOn,     
   
-- com.rejectComments,     
   
com.competitionAddedFor      
   
from tblCompetitions com    
   
inner join tblcustomers c on c.customerID = com.centerId    
   
inner join tblEmployees e on e.empid = com.empId     
   
where     
   
1 = 1    
   
-- and e.empId = 61    
   
 and  competitionAddedFor = @dateAddedFor     
   
-- and  competitionAddedFor = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-2, 0)      
   
group by e.empid, e.firstName, e.Designation,      
   
c.CENTRENAME,  c.DoctorName, com.centerId, com.isApproved,    
   
com.approvedBy, com.approvedOn, com.rejectedBy, com.rejectedOn, com.competitionAddedFor     
   
    
   
 order by e.firstName ASC    
   
    
   
    
   
    
   
END    
   
 