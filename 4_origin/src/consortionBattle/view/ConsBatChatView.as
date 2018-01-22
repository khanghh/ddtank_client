package consortionBattle.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.event.ConsBatEvent;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class ConsBatChatView extends Sprite implements Disposeable
   {
       
      
      private var _cellList:Array;
      
      private var _dataList:Array;
      
      public function ConsBatChatView()
      {
         _dataList = [];
         super();
         this.y = 116;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cellList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ConsBatChatViewCell();
            _loc1_.index = _loc2_;
            _loc1_.addEventListener("ConsBatChatViewCell_Guard_Complete",guardCompleteHandler,false,0,true);
            _loc1_.addEventListener("ConsBatChatViewCell_Disappear_Complete",disappearCompleteHandler,false,0,true);
            addChild(_loc1_);
            _cellList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function guardCompleteHandler(param1:Event) : void
      {
         if(!_dataList || _dataList.length <= 0)
         {
            return;
         }
         var _loc2_:ConsBatChatViewCell = param1.target as ConsBatChatViewCell;
         changeCellIndex(_loc2_);
         _loc2_.setText(getTxtStr(_dataList.splice(0,1)[0]));
      }
      
      private function disappearCompleteHandler(param1:Event) : void
      {
         var _loc2_:ConsBatChatViewCell = param1.target as ConsBatChatViewCell;
         changeCellIndex(_loc2_);
         if(_dataList && _dataList.length > 0)
         {
            _loc2_.setText(getTxtStr(_dataList.splice(0,1)[0]));
         }
      }
      
      private function changeCellIndex(param1:ConsBatChatViewCell) : void
      {
         if(param1.index == 0)
         {
            (_cellList[1] as ConsBatChatViewCell).index = 0;
            (_cellList[2] as ConsBatChatViewCell).index = 1;
         }
         else if(param1.index == 1)
         {
            (_cellList[2] as ConsBatChatViewCell).index = 1;
         }
         param1.index = 2;
         _cellList.sortOn("index",16);
      }
      
      private function getTxtStr(param1:Object) : String
      {
         var _loc2_:* = null;
         if(param1.type == 1)
         {
            if(param1.winningStreak == 3)
            {
               _loc2_ = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.threeWinningStreakTxt",param1.winner);
            }
            else if(param1.winningStreak == 6)
            {
               _loc2_ = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.sixWinningStreakTxt",param1.winner);
            }
            else if(param1.winningStreak >= 10)
            {
               _loc2_ = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.tenWinningStreakTxt",param1.winner);
            }
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.terminatorTxt",param1.winner,param1.loser,param1.winningStreak);
         }
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleBroadcast",getMessageHandler);
      }
      
      private function getMessageHandler(param1:ConsBatEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:Object = {};
         _loc2_.type = _loc3_.readByte();
         if(_loc2_.type == 1)
         {
            _loc2_.winningStreak = _loc3_.readInt();
            _loc2_.winner = _loc3_.readUTF();
         }
         else
         {
            _loc2_.winningStreak = _loc3_.readInt();
            _loc2_.loser = _loc3_.readUTF();
            _loc2_.winner = _loc3_.readUTF();
         }
         _dataList.push(_loc2_);
         setCellTxt();
      }
      
      private function setCellTxt() : void
      {
         var _loc1_:int = _cellList.length;
         var _loc2_:int = 0;
         _loc2_;
         while(_loc2_ < _loc1_)
         {
            if(!(_cellList[_loc2_] as ConsBatChatViewCell).isActive)
            {
               _cellList[_loc2_].setText(getTxtStr(_dataList.splice(0,1)[0]));
               break;
            }
            _loc2_++;
         }
         if(_loc2_ >= _loc1_)
         {
            if(!(_cellList[0] as ConsBatChatViewCell).isGuard)
            {
               _cellList[0].setText(getTxtStr(_dataList.splice(0,1)[0]));
               changeCellIndex(_cellList[0] as ConsBatChatViewCell);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleBroadcast",getMessageHandler);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _cellList[_loc1_].removeEventListener("ConsBatChatViewCell_Guard_Complete",guardCompleteHandler);
            _cellList[_loc1_].removeEventListener("ConsBatChatViewCell_Disappear_Complete",disappearCompleteHandler);
            _loc1_++;
         }
         ObjectUtils.disposeAllChildren(this);
         _cellList = null;
         _dataList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
