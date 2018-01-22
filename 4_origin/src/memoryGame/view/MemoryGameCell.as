package memoryGame.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import memoryGame.MemoryGameManager;
   
   public class MemoryGameCell extends Sprite implements Disposeable
   {
      
      private static const TURN_EVENT:String = "turnComplete";
      
      private static const PLAY_OPEN_COMPLETE:String = "playOpenComplete";
      
      private static const PLAY_CLOSE_COMPLETE:String = "playCloseComplete";
       
      
      private var _index:int = 0;
      
      private var _isOpen:Boolean;
      
      private var _turnMC:MovieClip;
      
      private var _cell:BagCell;
      
      public function MemoryGameCell(param1:int)
      {
         super();
         _index = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         buttonMode = true;
         _turnMC = ClassUtils.CreatInstance("asset.memoryGame.cellTurn");
         addChild(_turnMC);
         _cell = createCell();
         addChild(_cell);
      }
      
      public function open(param1:int, param2:int) : void
      {
         setInfo(param1,param2);
         if(!_isOpen)
         {
            MemoryGameManager.instance.playOpenStart();
            _isOpen = true;
            _turnMC.gotoAndPlay(3);
         }
      }
      
      public function close() : void
      {
         MemoryGameManager.instance.playCloseStart();
         _cell.visible = false;
         _turnMC.gotoAndPlay(32);
         _isOpen = false;
      }
      
      public function openDefault(param1:int, param2:int) : void
      {
         setInfo(param1,param2);
         _isOpen = true;
         _turnMC.gotoAndStop(2);
         _cell.visible = true;
      }
      
      public function closeDefault() : void
      {
         _cell.visible = false;
         _turnMC.gotoAndStop(1);
         _isOpen = false;
      }
      
      public function shine() : void
      {
      }
      
      private function setInfo(param1:int, param2:int) : void
      {
         if(!_cell.info || _cell.info.TemplateID != param1)
         {
            _cell.info = ItemManager.Instance.getTemplateById(param1);
         }
         _cell.setCount(param2);
      }
      
      private function __onTurnComplete(param1:Event) : void
      {
         _cell.visible = true;
      }
      
      private function __onPlayOpenComplete(param1:Event) : void
      {
         MemoryGameManager.instance.playOpenStop();
      }
      
      private function __onPlayCloseComplete(param1:Event) : void
      {
         MemoryGameManager.instance.playCloseStop();
      }
      
      private function createCell(param1:int = 11096) : BagCell
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(0,0,60,60);
         _loc3_.graphics.endFill();
         var _loc2_:BagCell = new BagCell(0,null,true,_loc3_,false);
         PositionUtils.setPos(_loc2_,"memoryGame.cellPos");
         return _loc2_;
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!MemoryGameManager.instance.isValid)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.activityTips"));
            return;
         }
         if(!_isOpen)
         {
            if(MemoryGameManager.instance.count > 0)
            {
               if(MemoryGameManager.instance.playActionAllComplete() && !MemoryGameManager.instance.turning)
               {
                  SocketManager.Instance.out.sendMemoryGameTurnover(_index);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.notTurn"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("memoryGame.cardOpenTips"));
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__onClick);
         _turnMC.addEventListener("turnComplete",__onTurnComplete);
         _turnMC.addEventListener("playOpenComplete",__onPlayOpenComplete);
         _turnMC.addEventListener("playCloseComplete",__onPlayCloseComplete);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__onClick);
         _turnMC.removeEventListener("turnComplete",__onTurnComplete);
         _turnMC.removeEventListener("playOpenComplete",__onPlayOpenComplete);
         _turnMC.removeEventListener("playCloseComplete",__onPlayCloseComplete);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _cell = null;
         _turnMC = null;
      }
   }
}
