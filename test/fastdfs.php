<?php
if($_FILES){
	$ret = uploadAttach();
	if(isset($ret['fileId'])){
		$retimgarr=pathinfo($ret['fileId']);
    	$retimgpre='http://192.168.102.163/'.$retimgarr['dirname'].'/'.$retimgarr['filename'];
    	$retimgext=$retimgarr['extension'];
	}   
}
//上传附件  
function uploadAttach()                                                                              
{/*{{{*/                                                                                                    
    $ret = array();  
    $ret['errorcode'] = 0;  
    $ret['errormsg'] = '';  
    if(!$_FILES || false == isset($_FILES["upFile"]))  
    {  
        $ret['errorcode'] = 1;  
        $ret['errormsg'] = "ERROR:upFile is not set";  
        return $ret;  
    }  
  
    $file = $_FILES["upFile"];  
    if (false == isset($file['tmp_name']) || false == is_file($file['tmp_name']))  
    {  
        $ret['errorcode'] = 2;  
        $ret['errormsg'] = "tmp_name is not file";  
        return $ret;  
    }  
    if (0 == filesize($file['tmp_name']))  
    {  
        $ret['errorcode'] = 3;  
        $ret['errormsg'] = "tmp_name filesize is 0";  
        return $ret;  
    }  
  
    $curlFile = new CurlFile($file['tmp_name'], $file['type'], $file['name']);    
    $fileSuffix = getSuffix($curlFile->getPostFilename());                                                
      
    $ret['file'] = $file;  
    $ret['fileId'] = uploadToFastdfs($curlFile, $fileSuffix);                                                          
    return $ret;  
}/*}}}*/                                                                                                    
  
//获取后缀  
 function getSuffix($fileName)   
 {/*{{{*/  
     preg_match('/\.(\w+)?$/', $fileName, $matchs);  
     return isset($matchs[1])?$matchs[1]:'';  
 }/*}}}*/  
  
//上传文件到fastdfs  
function uploadToFastdfs(CurlFile $file, $fileSuffix)                                                    
{/*{{{*/                                                                                                    
    $fdfs = new FastDFS();   
    $tracker = $fdfs->tracker_get_connection();    
    $fileId = $fdfs->storage_upload_by_filebuff1(file_get_contents($file->getFilename()), $fileSuffix);    
    $fdfs->tracker_close_all_connections();      
    return $fileId;  
}/*}}}*/                                                                                                    

?>
<!DOCTYPE html>
<html>
<head>
	<title>fastdfs</title>
</head>
<body>
<form  method="post" enctype="multipart/form-data">  
    <label for="file">Filename:</label>  
    <input type="file" name="upFile" id="upFile" />   
    <br />  
    <input type="submit" name="submit" value="上传" />  
</form>  
<?php if(isset($ret['fileId'])){ ?>
<img src="<?php echo $retimgpre.'.'.$retimgext;?>" /><br/>
<img src="<?php echo $retimgpre.'_100x100.'.$retimgext;?>" /><br/>
<img src="<?php echo $retimgpre.'_200x200.'.$retimgext;?>" /><br/>
<img src="<?php echo $retimgpre.'_300x300.'.$retimgext;?>" /><br/>
<img src="<?php echo $retimgpre.'_500x500.'.$retimgext;?>" /><br/>
<img src="<?php echo $retimgpre.'_800x800.'.$retimgext;?>" /><br/>
<?php } ?>
</html>