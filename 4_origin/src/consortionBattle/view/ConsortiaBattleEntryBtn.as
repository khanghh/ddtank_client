package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortiaBattleEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:MovieClip;
      
      private var _isOpen:Boolean;
      
      public function ConsortiaBattleEntryBtn()
      {
         super();
         this.x = 47;
         this.y = 217;
         if(ConsortiaBattleManager.instance.isLoadIconMapComplete)
         {
            initThis();
         }
         else
         {
            ConsortiaBattleManager.instance.addEventListener("consBatIconMapComplete",resLoadComplete);
         }
      }
      
      public function setEnble(bool:Boolean) : void
      {
         _isOpen = bool;
         mouseChildren = bool;
         mouseEnabled = bool;
         if(bool)
         {
            BuriedManager.Instance.reGray(this);
            playAllMc(_btn);
         }
         else
         {
            BuriedManager.Instance.applyGray(this);
         }
      }
      
      private function initThis() : void
      {
         _btn = ComponentFactory.Instance.creat("asset.consortiaBattle.entryBtn");
         _btn.gotoAndStop(1);
         _btn.buttonMode = true;
         addChild(_btn);
         _btn.addEventListener("click",clickhandler,false,0,true);
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleClose",closeHandler);
         if(!_isOpen)
         {
            stopAllMc(_btn);
         }
      }
      
      private function playAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
         if($mc)
         {
            while($mc.numChildren - index)
            {
               if($mc.getChildAt(index) is MovieClip)
               {
                  cMc = $mc.getChildAt(index) as MovieClip;
                  cMc.play();
                  playAllMc(cMc);
               }
               index++;
            }
         }
      }
      
      private function stopAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
         if($mc)
         {
            while($mc.numChildren - index)
            {
               if($mc.getChildAt(index) is MovieClip)
               {
                  cMc = $mc.getChildAt(index) as MovieClip;
                  cMc.stop();
                  stopAllMc(cMc);
               }
               index++;
            }
         }
      }
      
      private function clickhandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ConsortiaBattleManager.instance.isCanEnter)
         {
            GameInSocketOut.sendSingleRoomBegin(4);
         }
         else if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.cannotEnterTxt"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.cannotEnterTxt2"));
         }
      }
      
      private function resLoadComplete(event:Event) : void
      {
         ConsortiaBattleManager.instance.removeEventListener("consBatIconMapComplete",resLoadComplete);
         initThis();
      }
      
      private function closeHandler(event:Event) : void
      {
         closeDispose();
         ConsortiaBattleManager.instance.addEventListener("consBatIconMapComplete",resLoadComplete);
      }
      
      private function closeDispose() : void
      {
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleClose",closeHandler);
         if(_btn)
         {
            _btn.removeEventListener("click",clickhandler);
            _btn.gotoAndStop(2);
         }
         ObjectUtils.disposeAllChildren(this);
         _btn = null;
      }
      
      public function dispose() : void
      {
         ConsortiaBattleManager.instance.removeEventListener("consBatIconMapComplete",resLoadComplete);
         closeDispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
