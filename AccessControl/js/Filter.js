// numOnly		˹繵Ţҧѭѡɳ			Format = 1-Ţҧ; 0-ѭѡɳ;
// onKeyPress="Filter_Keyboard(1);"
function Filter_Keyboard( numOnly ) {			
	if (numOnly == 1)	//------------ Ţҧ
	{
		if ((event.keyCode <48 || event.keyCode > 57) ){  	//	 && (event.keyCode !=35) && (event.keyCode !=42)
			event.keyCode = 0
			return false
		} 
	}
	else	//---------------- ѭѡɳ  - # * : . 
	{
		if ((event.keyCode <48 || event.keyCode > 57) && (event.keyCode !=45) && (event.keyCode !=35) && (event.keyCode !=42) && (event.keyCode !=58) && (event.keyCode !=46) ){  
			event.keyCode = 0
			return false
		} 
	}
}

