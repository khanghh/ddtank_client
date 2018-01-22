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
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(WorldBossManager.Instance.iconEnterPath,4);
         _loc1_.addEventListener("complete",onIconLoadedComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function onIconLoadedComplete(param1:Event) : void
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
      
      private function stopAllMc(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(param1.numChildren - _loc3_)
         {
            if(param1.getChildAt(_loc3_) is MovieClip)
            {
               _loc2_ = param1.getChildAt(_loc3_) as MovieClip;
               _loc2_.stop();
               stopAllMc(_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function playAllMc(param1:MovieClip) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(param1.numChildren - _loc3_)
         {
            if(param1.getChildAt(_loc3_) is MovieClip)
            {
               _loc2_ = param1.getChildAt(_loc3_) as MovieClip;
               _loc2_.play();
               playAllMc(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function set enble(param1:Boolean) : void
      {
         _isOpen = param1;
         mouseEnabled = param1;
         mouseChildren = param1;
         if(!param1)
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
      
      private function __enterBossRoom(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         WorldBossManager.Instance.show();
      }
      
      public function setFrame(param1:int) : void
      {
         if(_dragon)
         {
            _dragon.gotoAndStop(param1);
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
