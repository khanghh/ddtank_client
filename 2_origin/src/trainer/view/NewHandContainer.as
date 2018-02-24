package trainer.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.PlayerManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import org.aswing.KeyboardManager;
   import trainer.controller.WeakGuildManager;
   
   public class NewHandContainer
   {
      
      private static var _instance:NewHandContainer;
       
      
      private var _arrows:Dictionary;
      
      private var _movies:Dictionary;
      
      private var _guideCover:GuideCover;
      
      private var _isEscDisabled:Boolean = false;
      
      public function NewHandContainer(param1:NewHandContainerEnforcer)
      {
         super();
         _arrows = new Dictionary();
         _movies = new Dictionary();
         _guideCover = new GuideCover();
         _guideCover.addEventListener("removedFromStage",onGuideRemoved);
      }
      
      public static function get Instance() : NewHandContainer
      {
         if(!_instance)
         {
            _instance = new NewHandContainer(new NewHandContainerEnforcer());
         }
         return _instance;
      }
      
      protected function onGuideRemoved(param1:Event) : void
      {
         unLockKeyBoard();
      }
      
      public function showGuideCover(param1:String, param2:Array, param3:int = 4, param4:Boolean = true) : void
      {
         if(param4)
         {
            lockKeyBoard();
         }
         _guideCover.parent && _guideCover.parent.removeChild(_guideCover);
         LayerManager.Instance.addToLayer(_guideCover,param3,false,0);
         _guideCover.dig(param1,param2);
      }
      
      public function showGuideCoverMultiHoles(param1:int, param2:Boolean, ... rest) : void
      {
         var _loc5_:int = 0;
         if(param2)
         {
            lockKeyBoard();
         }
         _guideCover.parent && _guideCover.parent.removeChild(_guideCover);
         LayerManager.Instance.addToLayer(_guideCover,param1,false,0);
         var _loc4_:int = rest.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _guideCover.dig(rest[_loc5_],rest[_loc5_ + 1]);
            _loc5_ = _loc5_ + 2;
         }
      }
      
      public function showCover(param1:uint, param2:Number, param3:int = 4, param4:Boolean = true) : void
      {
         if(param4)
         {
            lockKeyBoard();
         }
         _guideCover.parent && _guideCover.parent.removeChild(_guideCover);
         LayerManager.Instance.addToLayer(_guideCover,param3,false,0);
         _guideCover.drawCover(param1,param2);
      }
      
      public function hideGuideCover() : void
      {
      }
      
      private function lockKeyBoard() : void
      {
         if(_isEscDisabled == false)
         {
            _isEscDisabled = true;
            KeyboardManager.getInstance().addEventListener("keyDown",onKey,true,1);
            KeyboardManager.getInstance().addEventListener("keyUp",onKey,true,1);
            StageReferance.stage.addEventListener("keyDown",onKey,true,1);
            StageReferance.stage.addEventListener("keyUp",onKey,true,1);
            KeyboardShortcutsManager.Instance.forbiddenFull();
         }
      }
      
      private function unLockKeyBoard() : void
      {
         _isEscDisabled = false;
         KeyboardManager.getInstance().removeEventListener("keyDown",onKey,true);
         KeyboardManager.getInstance().removeEventListener("keyUp",onKey,true);
         StageReferance.stage.removeEventListener("keyDown",onKey,true);
         StageReferance.stage.removeEventListener("keyUp",onKey,true);
         KeyboardShortcutsManager.Instance.cancelForbidden();
      }
      
      protected function onKey(param1:KeyboardEvent) : void
      {
         if(_guideCover.parent == null)
         {
            unLockKeyBoard();
            return;
         }
         param1.stopImmediatePropagation();
      }
      
      public function showArrow(param1:int, param2:int, param3:*, param4:String = "", param5:String = "", param6:DisplayObjectContainer = null, param7:int = 0, param8:Boolean = false) : void
      {
         var _loc12_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         if(hasArrow(param1))
         {
            clearArrow(param1);
         }
         if(param1 != 128 && param1 != 129 && param1 != 142 && param1 != 153)
         {
            if(!param8)
            {
               if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
               {
                  return;
               }
            }
         }
         var _loc13_:Object = {};
         if(param3 is Point)
         {
            _loc12_ = param3;
         }
         else
         {
            _loc12_ = ComponentFactory.Instance.creatCustomObject(param3);
         }
         var _loc9_:MovieClip = ClassUtils.CreatInstance("asset.trainer.TrainerArrowAsset");
         _loc9_.mouseChildren = false;
         _loc9_.mouseEnabled = false;
         _loc9_.rotation = param2;
         _loc9_.x = _loc12_.x;
         _loc9_.y = _loc12_.y;
         if(param6)
         {
            param6.addChild(_loc9_);
         }
         else
         {
            LayerManager.Instance.addToLayer(_loc9_,4,false,0);
         }
         _loc13_["arrow"] = _loc9_;
         if(param4 != "")
         {
            _loc10_ = ClassUtils.CreatInstance(param4);
            _loc10_.mouseChildren = false;
            _loc10_.mouseEnabled = false;
            if(param5 != "")
            {
               _loc11_ = ComponentFactory.Instance.creatCustomObject(param5);
               _loc10_.x = _loc11_.x;
               _loc10_.y = _loc11_.y;
            }
            if(param6)
            {
               param6.addChild(_loc10_);
            }
            else
            {
               LayerManager.Instance.addToLayer(_loc10_,4,false,0);
            }
            _loc13_["tip"] = _loc10_;
         }
         _arrows[param1] = _loc13_;
         if(param7 > 0)
         {
            setTimeout(clearArrow,param7,param1);
         }
      }
      
      public function clearArrowByID(param1:int) : void
      {
         if(param1 == -1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _arrows;
            for(var _loc2_ in _arrows)
            {
               clearArrow(int(_loc2_));
            }
         }
         else
         {
            clearArrow(param1);
         }
      }
      
      public function hasArrow(param1:int) : Boolean
      {
         return _arrows[param1] != null;
      }
      
      public function showMovie(param1:String, param2:String = "") : void
      {
         var _loc4_:* = null;
         if(_movies[param1])
         {
            throw new Error("Already has a arrow with this id!");
         }
         var _loc3_:MovieClip = ClassUtils.CreatInstance(param1);
         var _loc5_:Boolean = false;
         _loc3_.mouseChildren = _loc5_;
         _loc3_.mouseEnabled = _loc5_;
         if(param2 != "")
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject(param2);
            _loc3_.x = _loc4_.x;
            _loc3_.y = _loc4_.y;
         }
         LayerManager.Instance.addToLayer(_loc3_,3,false,0);
         _movies[param1] = _loc3_;
      }
      
      public function hideMovie(param1:String) : void
      {
         if(param1 == "-1")
         {
            var _loc4_:int = 0;
            var _loc3_:* = _movies;
            for(var _loc2_ in _movies)
            {
               clearMovie(_loc2_);
            }
         }
         else
         {
            clearMovie(param1);
         }
      }
      
      private function clearArrow(param1:int) : void
      {
         var _loc2_:Object = _arrows[param1];
         if(_loc2_)
         {
            ObjectUtils.disposeObject(_loc2_["arrow"]);
            ObjectUtils.disposeObject(_loc2_["tip"]);
         }
      }
      
      private function clearMovie(param1:String) : void
      {
         ObjectUtils.disposeObject(_movies[param1]);
      }
      
      public function dispose() : void
      {
         _instance = null;
         _arrows = null;
         _movies = null;
      }
   }
}

class NewHandContainerEnforcer
{
    
   
   function NewHandContainerEnforcer()
   {
      super();
   }
}
