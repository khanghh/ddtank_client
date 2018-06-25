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
      
      public function NewHandContainer(enforcer:NewHandContainerEnforcer)
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
      
      protected function onGuideRemoved(e:Event) : void
      {
         unLockKeyBoard();
      }
      
      public function showGuideCover(guideCoverType:String, args:Array, layer:int = 4, isDisableESC:Boolean = true) : void
      {
         if(isDisableESC)
         {
            lockKeyBoard();
         }
         _guideCover.parent && _guideCover.parent.removeChild(_guideCover);
         LayerManager.Instance.addToLayer(_guideCover,layer,false,0);
         _guideCover.dig(guideCoverType,args);
      }
      
      public function showGuideCoverMultiHoles(layer:int, isDisableESC:Boolean, ... args) : void
      {
         var i:int = 0;
         if(isDisableESC)
         {
            lockKeyBoard();
         }
         _guideCover.parent && _guideCover.parent.removeChild(_guideCover);
         LayerManager.Instance.addToLayer(_guideCover,layer,false,0);
         var len:int = args.length;
         for(i = 0; i < len; )
         {
            _guideCover.dig(args[i],args[i + 1]);
            i = i + 2;
         }
      }
      
      public function showCover($color:uint, $alpha:Number, layer:int = 4, isDisableESC:Boolean = true) : void
      {
         if(isDisableESC)
         {
            lockKeyBoard();
         }
         _guideCover.parent && _guideCover.parent.removeChild(_guideCover);
         LayerManager.Instance.addToLayer(_guideCover,layer,false,0);
         _guideCover.drawCover($color,$alpha);
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
      
      protected function onKey(e:KeyboardEvent) : void
      {
         if(_guideCover.parent == null)
         {
            unLockKeyBoard();
            return;
         }
         e.stopImmediatePropagation();
      }
      
      public function showArrow(id:int, rotation:int, arrowPos:*, tip:String = "", tipPos:String = "", con:DisplayObjectContainer = null, delay:int = 0, isFarmGuild:Boolean = false) : void
      {
         var arPos:* = null;
         var mcTip:* = null;
         var tPos:* = null;
         if(hasArrow(id))
         {
            clearArrow(id);
         }
         if(id != 128 && id != 129 && id != 142 && id != 153)
         {
            if(!isFarmGuild)
            {
               if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
               {
                  return;
               }
            }
         }
         var obj:Object = {};
         if(arrowPos is Point)
         {
            arPos = arrowPos;
         }
         else
         {
            arPos = ComponentFactory.Instance.creatCustomObject(arrowPos);
         }
         var arrow:MovieClip = ClassUtils.CreatInstance("asset.trainer.TrainerArrowAsset");
         arrow.mouseChildren = false;
         arrow.mouseEnabled = false;
         arrow.rotation = rotation;
         arrow.x = arPos.x;
         arrow.y = arPos.y;
         if(con)
         {
            con.addChild(arrow);
         }
         else
         {
            LayerManager.Instance.addToLayer(arrow,4,false,0);
         }
         obj["arrow"] = arrow;
         if(tip != "")
         {
            mcTip = ClassUtils.CreatInstance(tip);
            mcTip.mouseChildren = false;
            mcTip.mouseEnabled = false;
            if(tipPos != "")
            {
               tPos = ComponentFactory.Instance.creatCustomObject(tipPos);
               mcTip.x = tPos.x;
               mcTip.y = tPos.y;
            }
            if(con)
            {
               con.addChild(mcTip);
            }
            else
            {
               LayerManager.Instance.addToLayer(mcTip,4,false,0);
            }
            obj["tip"] = mcTip;
         }
         _arrows[id] = obj;
         if(delay > 0)
         {
            setTimeout(clearArrow,delay,id);
         }
      }
      
      public function clearArrowByID(id:int) : void
      {
         if(id == -1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _arrows;
            for(var i in _arrows)
            {
               clearArrow(int(i));
            }
         }
         else
         {
            clearArrow(id);
         }
      }
      
      public function hasArrow(id:int) : Boolean
      {
         return _arrows[id] != null;
      }
      
      public function showMovie(styleName:String, pos:String = "") : void
      {
         var p:* = null;
         if(_movies[styleName])
         {
            throw new Error("Already has a arrow with this id!");
         }
         var mc:MovieClip = ClassUtils.CreatInstance(styleName);
         var _loc5_:Boolean = false;
         mc.mouseChildren = _loc5_;
         mc.mouseEnabled = _loc5_;
         if(pos != "")
         {
            p = ComponentFactory.Instance.creatCustomObject(pos);
            mc.x = p.x;
            mc.y = p.y;
         }
         LayerManager.Instance.addToLayer(mc,3,false,0);
         _movies[styleName] = mc;
      }
      
      public function hideMovie(styleName:String) : void
      {
         if(styleName == "-1")
         {
            var _loc4_:int = 0;
            var _loc3_:* = _movies;
            for(var s in _movies)
            {
               clearMovie(s);
            }
         }
         else
         {
            clearMovie(styleName);
         }
      }
      
      private function clearArrow(id:int) : void
      {
         var obj:Object = _arrows[id];
         if(obj)
         {
            ObjectUtils.disposeObject(obj["arrow"]);
            ObjectUtils.disposeObject(obj["tip"]);
         }
      }
      
      private function clearMovie(styleName:String) : void
      {
         ObjectUtils.disposeObject(_movies[styleName]);
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
