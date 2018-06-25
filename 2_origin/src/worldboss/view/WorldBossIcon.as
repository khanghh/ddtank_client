package worldboss.view
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossIcon extends Sprite
   {
       
      
      private var _dragon:MovieClip;
      
      private var _isOpen:Boolean;
      
      public function WorldBossIcon()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var iconLoader:BaseLoader = LoadResourceManager.Instance.createLoader(WorldBossManager.Instance.iconEnterPath,4);
         iconLoader.addEventListener("complete",onIconLoadedComplete);
         LoadResourceManager.Instance.startLoad(iconLoader);
      }
      
      private function onIconLoadedComplete(e:Event) : void
      {
         _dragon = ComponentFactory.Instance.creat("asset.hall.worldBossEntrance-" + WorldBossManager.Instance.BossResourceId);
         _dragon.buttonMode = true;
         addChild(_dragon);
         if(WorldBossManager.Instance.bossInfo)
         {
            _dragon.gotoAndStop(!!WorldBossManager.Instance.bossInfo.fightOver?2:1);
         }
         else
         {
            _dragon.gotoAndStop(1);
         }
         addEvent();
         _dragon.y = -_dragon.height / 2;
         if(!_isOpen)
         {
            stopAllMc(_dragon);
         }
      }
      
      private function stopAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
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
      
      private function playAllMc($mc:MovieClip) : void
      {
         var cMc:* = null;
         var index:int = 0;
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
      
      public function set enble(bool:Boolean) : void
      {
         _isOpen = bool;
         mouseEnabled = bool;
         mouseChildren = bool;
         if(!bool)
         {
            BuriedManager.Instance.applyGray(this);
         }
         else
         {
            BuriedManager.Instance.reGray(this);
            if(_dragon)
            {
               playAllMc(_dragon);
            }
         }
      }
      
      private function addEvent() : void
      {
         _dragon.addEventListener("click",__enterBossRoom);
      }
      
      private function removeEvent() : void
      {
         if(_dragon)
         {
            _dragon.removeEventListener("click",__enterBossRoom);
         }
      }
      
      private function __enterBossRoom(e:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         WorldBossManager.Instance.show();
      }
      
      public function setFrame(value:int) : void
      {
         if(_dragon)
         {
            _dragon.gotoAndStop(value);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _dragon = null;
      }
   }
}
