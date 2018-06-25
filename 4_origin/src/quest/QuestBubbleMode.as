package quest
{
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   
   public class QuestBubbleMode
   {
       
      
      private var _questInfoCompleteArr:Array;
      
      private var _questInfoArr:Array;
      
      private var _questInfoTxtArr:Array;
      
      private var _isShowIn:Boolean;
      
      public function QuestBubbleMode()
      {
         super();
      }
      
      public function get questsInfo() : Array
      {
         var arr:Array = [];
         _questInfoCompleteArr = [];
         _questInfoArr = [];
         arr = TaskManager.instance.getAvailableQuests().list;
         return _reseachComplete(arr);
      }
      
      private function _addInfoToArr(info:QuestInfo) : void
      {
         if(info.canViewWithProgress && _questInfoArr.length < 5 && (!_isShowIn || _isShowIn && info.isCompleted))
         {
            _questInfoArr.push(info);
         }
      }
      
      private function _reseachComplete(arr:Array) : Array
      {
         _reseachInfoForId(arr);
         return _setTxtInArr();
      }
      
      private function _setTxtInArr() : Array
      {
         var i:int = 0;
         var dn:* = 0;
         var numerator:Number = NaN;
         var denominator:Number = NaN;
         var n:int = 0;
         var dnumerator:int = 0;
         var ddenominator:int = 0;
         var obj:* = null;
         var arr:Array = [];
         for(i = 0; i < _questInfoArr.length; )
         {
            dn = 0;
            numerator = QuestInfo(_questInfoArr[i]).progress[0];
            denominator = QuestInfo(_questInfoArr[i]).conditions[0].target;
            n = 1;
            while(QuestInfo(_questInfoArr[i]).conditions[n])
            {
               dnumerator = QuestInfo(_questInfoArr[i]).progress[n];
               ddenominator = QuestInfo(_questInfoArr[i]).conditions[n].target;
               if(dnumerator != 0)
               {
                  if(dnumerator / ddenominator < numerator / denominator || numerator == 0)
                  {
                     numerator = dnumerator;
                     denominator = ddenominator;
                     dn = n;
                  }
               }
               n++;
            }
            obj = {};
            switch(int(QuestInfo(_questInfoArr[i]).Type))
            {
               case 0:
                  obj.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.TankLink");
                  break;
               case 1:
                  obj.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.BranchLine");
                  break;
               case 2:
                  obj.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.Daily");
                  break;
               case 3:
                  obj.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
                  break;
               case 4:
                  obj.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.VIP");
            }
            if(QuestInfo(_questInfoArr[i]).isCompleted)
            {
               obj.txtI = "<font COLOR=\'#8be961\'>" + obj.txtI + "</font>";
               obj.txtII = "<font COLOR=\'#8be961\'>" + _analysisStrIII(QuestInfo(_questInfoArr[i])) + "</font>";
               obj.txtIII = "<font COLOR=\'#8be961\'>" + _analysisStrIV(QuestInfo(_questInfoArr[i])) + "</font>";
            }
            else
            {
               obj.txtII = _analysisStrII(QuestInfo(_questInfoArr[i]).conditions[dn].description);
               obj.txtIII = QuestInfo(_questInfoArr[i]).conditionStatus[dn];
            }
            arr.push(obj);
            i++;
         }
         return arr;
      }
      
      private function _analysisStrII(strII:String) : String
      {
         var str:* = null;
         if(strII.length <= 6)
         {
            str = strII;
         }
         else
         {
            str = strII.substr(0,6);
            str = str + "...";
         }
         return str;
      }
      
      private function _analysisStrIII(questInfo:QuestInfo) : String
      {
         var i:int = 0;
         var str:String = "";
         for(i = 0; i < questInfo.conditions.length; )
         {
            trace(questInfo.conditions[i].description);
            if(questInfo.progress[i] <= 0 || questInfo.isCompleted)
            {
               str = questInfo.conditions[i].description;
               return str;
            }
            i++;
         }
         return str;
      }
      
      private function _analysisStrIV(questInfo:QuestInfo) : String
      {
         var i:int = 0;
         var str:String = "";
         for(i = 0; i < questInfo.conditions.length; )
         {
            if(questInfo.progress[i] <= 0 || questInfo.isCompleted)
            {
               str = questInfo.conditionStatus[i];
               return str;
            }
            i++;
         }
         return str;
      }
      
      private function _reseachInfoForId(arr:Array) : void
      {
         var i:int = 0;
         var num:Number = NaN;
         var obj:* = null;
         var numArr:Array = [];
         var completeArray:Array = [];
         var noCompleteArray:Array = [];
         for(i = 0; i < arr.length; )
         {
            num = QuestInfo(arr[i]).questProgressNum;
            obj = new IndexObj(i,num);
            if(QuestInfo(arr[i]).isCompleted)
            {
               completeArray.push(obj);
            }
            else
            {
               noCompleteArray.push(obj);
            }
            i++;
         }
         completeArray.sortOn("progressNum",16);
         noCompleteArray.sortOn("progressNum",16);
         numArr = completeArray.concat(noCompleteArray);
         for(i = 0; i < numArr.length; )
         {
            _questInfoCompleteArr.push(QuestInfo(arr[numArr[i].id]));
            i++;
         }
         var n:* = 0;
         for(i = 0; i < _questInfoCompleteArr.length; )
         {
            if(_questInfoCompleteArr[i].questProgressNum != _questInfoCompleteArr[n].questProgressNum)
            {
               _checkInfoArr(4,n,i);
               _checkInfoArr(3,n,i);
               _checkInfoArr(2,n,i);
               _checkInfoArr(0,n,i);
               _checkInfoArr(1,n,i);
               n = i;
            }
            i++;
         }
         _checkInfoArr(4,n,_questInfoCompleteArr.length);
         _checkInfoArr(3,n,_questInfoCompleteArr.length);
         _checkInfoArr(2,n,_questInfoCompleteArr.length);
         _checkInfoArr(0,n,_questInfoCompleteArr.length);
         _checkInfoArr(1,n,_questInfoCompleteArr.length);
      }
      
      private function _checkInfoArr(id:int, idI:int, idII:int) : void
      {
         var i:* = 0;
         for(i = idI; i < idII; )
         {
            if(QuestInfo(_questInfoCompleteArr[i]).Type == id)
            {
               _addInfoToArr(_questInfoCompleteArr[i]);
            }
            i++;
         }
      }
      
      public function getQuestInfoById(id:int) : QuestInfo
      {
         return _questInfoArr[id];
      }
   }
}

class IndexObj
{
    
   
   public var id:int;
   
   public var progressNum:Number;
   
   function IndexObj(numI:int, numII:Number)
   {
      super();
      this.id = numI;
      this.progressNum = numII;
   }
}
