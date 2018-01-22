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
         var _loc1_:Array = [];
         _questInfoCompleteArr = [];
         _questInfoArr = [];
         _loc1_ = TaskManager.instance.getAvailableQuests().list;
         return _reseachComplete(_loc1_);
      }
      
      private function _addInfoToArr(param1:QuestInfo) : void
      {
         if(param1.canViewWithProgress && _questInfoArr.length < 5 && (!_isShowIn || _isShowIn && param1.isCompleted))
         {
            _questInfoArr.push(param1);
         }
      }
      
      private function _reseachComplete(param1:Array) : Array
      {
         _reseachInfoForId(param1);
         return _setTxtInArr();
      }
      
      private function _setTxtInArr() : Array
      {
         var _loc9_:int = 0;
         var _loc7_:* = 0;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _questInfoArr.length)
         {
            _loc7_ = 0;
            _loc5_ = QuestInfo(_questInfoArr[_loc9_]).progress[0];
            _loc4_ = QuestInfo(_questInfoArr[_loc9_]).conditions[0].target;
            _loc2_ = 1;
            while(QuestInfo(_questInfoArr[_loc9_]).conditions[_loc2_])
            {
               _loc6_ = QuestInfo(_questInfoArr[_loc9_]).progress[_loc2_];
               _loc8_ = QuestInfo(_questInfoArr[_loc9_]).conditions[_loc2_].target;
               if(_loc6_ != 0)
               {
                  if(_loc6_ / _loc8_ < _loc5_ / _loc4_ || _loc5_ == 0)
                  {
                     _loc5_ = _loc6_;
                     _loc4_ = _loc8_;
                     _loc7_ = _loc2_;
                  }
               }
               _loc2_++;
            }
            _loc3_ = {};
            switch(int(QuestInfo(_questInfoArr[_loc9_]).Type))
            {
               case 0:
                  _loc3_.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.TankLink");
                  break;
               case 1:
                  _loc3_.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.BranchLine");
                  break;
               case 2:
                  _loc3_.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.Daily");
                  break;
               case 3:
                  _loc3_.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.Act");
                  break;
               case 4:
                  _loc3_.txtI = LanguageMgr.GetTranslation("tank.view.quest.bubble.VIP");
            }
            if(QuestInfo(_questInfoArr[_loc9_]).isCompleted)
            {
               _loc3_.txtI = "<font COLOR=\'#8be961\'>" + _loc3_.txtI + "</font>";
               _loc3_.txtII = "<font COLOR=\'#8be961\'>" + _analysisStrIII(QuestInfo(_questInfoArr[_loc9_])) + "</font>";
               _loc3_.txtIII = "<font COLOR=\'#8be961\'>" + _analysisStrIV(QuestInfo(_questInfoArr[_loc9_])) + "</font>";
            }
            else
            {
               _loc3_.txtII = _analysisStrII(QuestInfo(_questInfoArr[_loc9_]).conditions[_loc7_].description);
               _loc3_.txtIII = QuestInfo(_questInfoArr[_loc9_]).conditionStatus[_loc7_];
            }
            _loc1_.push(_loc3_);
            _loc9_++;
         }
         return _loc1_;
      }
      
      private function _analysisStrII(param1:String) : String
      {
         var _loc2_:* = null;
         if(param1.length <= 6)
         {
            _loc2_ = param1;
         }
         else
         {
            _loc2_ = param1.substr(0,6);
            _loc2_ = _loc2_ + "...";
         }
         return _loc2_;
      }
      
      private function _analysisStrIII(param1:QuestInfo) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.conditions.length)
         {
            trace(param1.conditions[_loc3_].description);
            if(param1.progress[_loc3_] <= 0 || param1.isCompleted)
            {
               _loc2_ = param1.conditions[_loc3_].description;
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function _analysisStrIV(param1:QuestInfo) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.conditions.length)
         {
            if(param1.progress[_loc3_] <= 0 || param1.isCompleted)
            {
               _loc2_ = param1.conditionStatus[_loc3_];
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function _reseachInfoForId(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc2_:Number = NaN;
         var _loc6_:* = null;
         var _loc8_:Array = [];
         var _loc5_:Array = [];
         var _loc4_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc2_ = QuestInfo(param1[_loc7_]).questProgressNum;
            _loc6_ = new IndexObj(_loc7_,_loc2_);
            if(QuestInfo(param1[_loc7_]).isCompleted)
            {
               _loc5_.push(_loc6_);
            }
            else
            {
               _loc4_.push(_loc6_);
            }
            _loc7_++;
         }
         _loc5_.sortOn("progressNum",16);
         _loc4_.sortOn("progressNum",16);
         _loc8_ = _loc5_.concat(_loc4_);
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            _questInfoCompleteArr.push(QuestInfo(param1[_loc8_[_loc7_].id]));
            _loc7_++;
         }
         var _loc3_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < _questInfoCompleteArr.length)
         {
            if(_questInfoCompleteArr[_loc7_].questProgressNum != _questInfoCompleteArr[_loc3_].questProgressNum)
            {
               _checkInfoArr(4,_loc3_,_loc7_);
               _checkInfoArr(3,_loc3_,_loc7_);
               _checkInfoArr(2,_loc3_,_loc7_);
               _checkInfoArr(0,_loc3_,_loc7_);
               _checkInfoArr(1,_loc3_,_loc7_);
               _loc3_ = _loc7_;
            }
            _loc7_++;
         }
         _checkInfoArr(4,_loc3_,_questInfoCompleteArr.length);
         _checkInfoArr(3,_loc3_,_questInfoCompleteArr.length);
         _checkInfoArr(2,_loc3_,_questInfoCompleteArr.length);
         _checkInfoArr(0,_loc3_,_questInfoCompleteArr.length);
         _checkInfoArr(1,_loc3_,_questInfoCompleteArr.length);
      }
      
      private function _checkInfoArr(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = 0;
         _loc4_ = param2;
         while(_loc4_ < param3)
         {
            if(QuestInfo(_questInfoCompleteArr[_loc4_]).Type == param1)
            {
               _addInfoToArr(_questInfoCompleteArr[_loc4_]);
            }
            _loc4_++;
         }
      }
      
      public function getQuestInfoById(param1:int) : QuestInfo
      {
         return _questInfoArr[param1];
      }
   }
}

class IndexObj
{
    
   
   public var id:int;
   
   public var progressNum:Number;
   
   function IndexObj(param1:int, param2:Number)
   {
      super();
      this.id = param1;
      this.progressNum = param2;
   }
}
