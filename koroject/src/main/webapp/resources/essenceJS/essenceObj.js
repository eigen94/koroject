//
//에센스 저장을 위한 객체 설정
//
var essence = {
		$this : this,
		//마일스톤을 담아놓는 배열객체
		milestone : [],
		//내부 명령을 위한 함수
		set : function(hashId,attr,newValue,newValue2,newValue3){
			for(var i=0; i<(this.milestone).length; i++){
				
				//뷰에서 체크리스트별 점수를 매겼을때 점수를 객체에 반영해주기 위한 함수 
				if(attr=="alphastateValue")
				{
					if((this.milestone[i].alphaState)!=undefined){//알파상태가 하나도 없을때 발생하는 에러를 방지하기 위한 부분
						for(var j=0;j<(this.milestone[i].alphaState).length;j++){
							if(this.milestone[i].alphaState[j].hashId==hashId){//수정 해야 할 해당 알파 검사 
								if(this.milestone[i].alphaState[j ].checkvalue==undefined){//한번도 점수 수정을 안하면 배열이 없으므로 배열등록
									console.log(essenceJsonData[this.milestone[i].alphaState[j].alphaID].checkList);
									var zeroPadding = essenceJsonData[this.milestone[i].alphaState[j].alphaID].checkList.length;
									console.log("zero padding :"+zeroPadding);
									this.milestone[i].alphaState[j].checkvalue=[];
									for(var k=0; k<zeroPadding;k++){
										this.milestone[i].alphaState[j].checkvalue.push(0);
									}
								}//end of if 
								//체크리스트 점수 반영
								var index = newValue;
								var value = newValue2;
								this.milestone[i].alphaState[j].checkvalue.splice(index,1,value);
							}//end of if
						}//end of scan for loop
					}//end of alphastate length Check
				}//end of alphaStateValue command
			
				//객체 속성 수정하는 부분
				if((this.milestone[i]).hashId==hashId){
					if(attr=="name"){
						(this.milestone[i]).name = newValue;
					}
					else if(attr=="milestoneHead")
						{
						this.milestone[i].milestoneHead=newValue
						}
					else if(attr=="milestoneDue")
						{
						this.milestone[i].milestoneDue=newValue
						}
					else if(attr=="milestoneDef")
						{
						this.milestone[i].milestoneDef=newValue
						}
					else if(attr=="milestoneGoal")
						{
						this.milestone[i].milestoneGoal=newValue
						}
					else if(attr=="milestoneNote")
						{
						this.milestone[i].milestoneNote=newValue
						}
					else if(attr=="index")
						{
						var tmp = this.milestone[i];
						(this.milestone).splice(i,1);
						(this.milestone).splice(newValue,0,tmp);
						break;
						}
					else if(attr=="remove")
						{
						console.log("remove");
						(this.milestone).splice(i,1);
						$("#"+hashId).remove();
						}
					//알파상태
					else if(attr=="milestoneTask")
						{
						this.milestone[i].milestoneTask=newValue
						}
					else if(attr=="milestoneResult")
						{
						this.milestone[i].milestoneResult=newValue
						}
					else if(attr=="milestoneNote2")
						{
						this.milestone[i].milestoneNote2=newValue
						}
					else if(attr=="addAlpha")
						{
						if(this.milestone[i].alphaState==undefined)//최초에 행렬등록
							{
							this.milestone[i].alphaState=[];
							this.milestone[i].alphaState.push({"alphaID":newValue,"name":newValue2,"hashId":newValue3});
							//console.log("등록");
							}
						else
							{
							this.milestone[i].alphaState.push({"alphaID":newValue,"name":newValue2,"hashId":newValue3});
							//console.log("등록");
							}
						}
					else if(attr=="removeAlpha")
						{
						for(var j=0;j<(this.milestone[i].alphaState).length;j++){
							if(this.milestone[i].alphaState[j].hashId==newValue){
								this.milestone[i].alphaState.splice(j,1);
								//console.log("삭제")
							}
						}
						
						}

					//수행테스크
					
				}//end of 객체 수정 if
			}//end of 'Fn set' for loop
		},
		get : function(attr){
			if(attr=="alpha"){
				var alphastateList = [];
				for(var i=0; i<(essence.milestone).length;i++){
					if(essence.milestone[i].alphaState!=undefined){
						for(var j=0; j<(essence.milestone[i].alphaState).length;j++){
							//console.log(essence.milestone[i].alphaState[j]);
							alphastateList.push(essence.milestone[i].alphaState[j]);
						}
					}
				}
				//정렬 알고리즘 추가할것
				//console.log(alphastateList);
				return alphastateList;
			}
		},
		importJson : function(data){
			//console.log(data);
			var obj = data;
			//console.log("importJson : "+obj);
			//console.log(obj);
			//console.log(JSON.parse(obj));
			this.milestone = JSON.parse(obj);
			//this.milestone = data;
		},
		exportJson : function(){
			var tmp = JSON.stringify(this.milestone);
			//console.log(tmp);
			return tmp;
		}
		
}//end of essence