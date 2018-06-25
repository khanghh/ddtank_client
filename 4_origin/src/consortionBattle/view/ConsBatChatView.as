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
         var i:int = 0;
         var cell:* = null;
         _cellList = [];
         for(i = 0; i < 3; )
         {
            cell = new ConsBatChatViewCell();
            cell.index = i;
            cell.addEventListener("ConsBatChatViewCell_Guard_Complete",guardCompleteHandler,false,0,true);
            cell.addEventListener("ConsBatChatViewCell_Disappear_Complete",disappearCompleteHandler,false,0,true);
            addChild(cell);
            _cellList.push(cell);
            i++;
         }
      }
      
      private function guardCompleteHandler(event:Event) : void
      {
         if(!_dataList || _dataList.length <= 0)
         {
            return;
         }
         var cell:ConsBatChatViewCell = event.target as ConsBatChatViewCell;
         changeCellIndex(cell);
         cell.setText(getTxtStr(_dataList.splice(0,1)[0]));
      }
      
      private function disappearCompleteHandler(event:Event) : void
      {
         var cell:ConsBatChatViewCell = event.target as ConsBatChatViewCell;
         changeCellIndex(cell);
         if(_dataList && _dataList.length > 0)
         {
            cell.setText(getTxtStr(_dataList.splice(0,1)[0]));
         }
      }
      
      private function changeCellIndex(cell:ConsBatChatViewCell) : void
      {
         if(cell.index == 0)
         {
            (_cellList[1] as ConsBatChatViewCell).index = 0;
            (_cellList[2] as ConsBatChatViewCell).index = 1;
         }
         else if(cell.index == 1)
         {
            (_cellList[2] as ConsBatChatViewCell).index = 1;
         }
         cell.index = 2;
         _cellList.sortOn("index",16);
      }
      
      private function getTxtStr(data:Object) : String
      {
         var tmp:* = null;
         if(data.type == 1)
         {
            if(data.winningStreak == 3)
            {
               tmp = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.threeWinningStreakTxt",data.winner);
            }
            else if(data.winningStreak == 6)
            {
               tmp = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.sixWinningStreakTxt",data.winner);
            }
            else if(data.winningStreak >= 10)
            {
               tmp = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.tenWinningStreakTxt",data.winner);
            }
         }
         else
         {
            tmp = LanguageMgr.GetTranslation("ddt.consortiaBattle.chatPrompt.terminatorTxt",data.winner,data.loser,data.winningStreak);
         }
         return tmp;
      }
      
      private function initEvent() : void
      {
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleBroadcast",getMessageHandler);
      }
      
      private function getMessageHandler(event:ConsBatEvent) : void
      {
         var pkg:PackageIn = event.data as PackageIn;
         var tmpData:Object = {};
         tmpData.type = pkg.readByte();
         if(tmpData.type == 1)
         {
            tmpData.winningStreak = pkg.readInt();
            tmpData.winner = pkg.readUTF();
         }
         else
         {
            tmpData.winningStreak = pkg.readInt();
            tmpData.loser = pkg.readUTF();
            tmpData.winner = pkg.readUTF();
         }
         _dataList.push(tmpData);
         setCellTxt();
      }
      
      private function setCellTxt() : void
      {
         var len:int = _cellList.length;
         var i:int = 0;
         i;
         while(i < len)
         {
            if(!(_cellList[i] as ConsBatChatViewCell).isActive)
            {
               _cellList[i].setText(getTxtStr(_dataList.splice(0,1)[0]));
               break;
            }
            i++;
         }
         if(i >= len)
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
         var i:int = 0;
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleBroadcast",getMessageHandler);
         for(i = 0; i < 3; )
         {
            _cellList[i].removeEventListener("ConsBatChatViewCell_Guard_Complete",guardCompleteHandler);
            _cellList[i].removeEventListener("ConsBatChatViewCell_Disappear_Complete",disappearCompleteHandler);
            i++;
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
