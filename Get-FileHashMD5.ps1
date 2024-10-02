param (  
     $folders = @("C:\temp_fotos\", "C:\fotos_temp\") #case sensitive  
 )    
   
 $allFiles = foreach($folder in $folders) {  
     Get-Childitem -path $folder -recurse |  
        select FullName,Name,Length |   
        foreach {  
            $hash = Get-FileHash -Algorithm MD5 $_.FullName   
            add-member -InputObject $_ -NotePropertyName Hash -NotePropertyValue $hash.Hash  
            add-member -InputObject $_ -NotePropertyName RelativePath -NotePropertyValue $_.FullName.Replace($folder, '') -PassThru        
        }  
 }  
  
 $allFiles | select -First 10 | ft RelativePath, Hash   
