package ddt.manager
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DragManager extends EventDispatcher
   {
      
      public static const DRAG_IN_RANGE_TOP:String = "dragInRangeTop";
      
      public static const DRAG_IN_RANGE_BUTTOM:String = "dragOutRangeButtom";
      
      public static const DRAG_IN_HOT:String = "dragInHot";
      
      private static var _isDraging:Boolean;
      
      private static var _proxy:Sprite;
      
      private static var _dragEffect:DragEffect;
      
      private static var _source:IDragable;
      
      private static var _throughAll:Boolean;
      
      private static var _wheelFun:Function;
      
      private static var _passSelf:Boolean;
      
      private static var _isUpDrag:Boolean;
      
      private static var _changCardStateFun:Function;
      
      private static var _responseRectangle:DisplayObject;
      
      private static var _responseRange:int;
      
      private static var _isContinue:Boolean;
       
      
      public function DragManager()
      {
         super();
      }
      
      public static function get proxy() : Sprite
      {
         return _proxy;
      }
      
      public static function get isDraging() : Boolean
      {
         return _isDraging;
      }
      
      public static function startDrag(param1:IDragable, param2:Object, param3:DisplayObject, param4:int, param5:int, param6:String = "none", param7:Boolean = true, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:DisplayObject = null, param13:int = 0, param14:Boolean = false) : Boolean
      {
         if(!_isDraging && param3)
         {
            _responseRectangle = param12;
            _responseRange = param13;
            _isContinue = param14;
            _passSelf = param10;
            _isUpDrag = param11;
            _isDraging = true;
            _proxy = new Sprite();
            param3.x = -param3.width / 2;
            param3.y = -param3.height / 2;
            _proxy.addChild(param3);
            InGameCursor.hide();
            _proxy.x = param4;
            _proxy.y = param5;
            _proxy.mouseEnabled = param7;
            _proxy.mouseChildren = false;
            _proxy.startDrag();
            _throughAll = param9;
            _dragEffect = new DragEffect(param1.getSource(),param2,param6);
            _source = param1;
            LayerManager.Instance.addToLayer(_proxy,1);
            if(param7)
            {
               _proxy.addEventListener("click",__stopDrag);
               _proxy.addEventListener("mouseUp",__upDrag);
               _proxy.addEventListener("mouseWheel",__dispatchWheel);
            }
            else
            {
               if(!param8)
               {
                  _proxy.stage.addEventListener("mouseDown",__stageMouseDown,true);
               }
               _proxy.stage.addEventListener("click",__stopDrag,true);
               _proxy.stage.addEventListener("mouseUp",__upDrag,true);
               _proxy.parent.mouseEnabled = false;
            }
            if(_responseRectangle != null && _responseRange != 0)
            {
               _proxy.addEventListener("enterFrame",__checkResponse);
            }
            _proxy.addEventListener("removedFromStage",__removeFromStage);
            return true;
         }
         return false;
      }
      
      protected static function __checkResponse(param1:Event) : void
      {
         var _loc4_:Boolean = _proxy.stage.mouseY > _responseRectangle.y && _proxy.stage.mouseY < _responseRectangle.y + _responseRange;
         var _loc2_:Boolean = _proxy.stage.mouseY > _responseRectangle.y + _responseRectangle.height - _responseRange && _proxy.stage.mouseY < _responseRectangle.y + _responseRectangle.height;
         var _loc3_:Boolean = _proxy.stage.mouseX > _responseRectangle.x && _proxy.stage.mouseX < _responseRectangle.x + _responseRectangle.width;
         if(_loc4_ && _loc3_)
         {
            _responseRectangle.dispatchEvent(new Event("dragInRangeTop"));
         }
         else if(_loc2_ && _loc3_)
         {
            _responseRectangle.dispatchEvent(new Event("dragOutRangeButtom"));
         }
      }
      
      public static function ListenWheelEvent(param1:Function) : void
      {
         _wheelFun = param1;
      }
      
      public static function removeListenWheelEvent() : void
      {
         _wheelFun = null;
         _changCardStateFun = null;
      }
      
      private static function __dispatchWheel(param1:MouseEvent) : void
      {
         if(_passSelf && _wheelFun != null)
         {
            _wheelFun(param1);
         }
      }
      
      public static function changeCardState(param1:Function) : void
      {
         _changCardStateFun = param1;
      }
      
      private static function __stageMouseDown(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         if(_proxy.stage)
         {
            _proxy.stage.removeEventListener("mouseDown",__stageMouseDown,true);
         }
      }
      
      private static function __removeFromStage(param1:Event) : void
      {
         _proxy.removeEventListener("click",__stopDrag);
         _proxy.removeEventListener("mouseUp",__upDrag);
         _proxy.removeEventListener("removedFromStage",__removeFromStage);
         _proxy.stage.removeEventListener("mouseDown",__stageMouseDown,true);
         _proxy.removeEventListener("mouseWheel",__dispatchWheel);
         if(_responseRectangle != null && _responseRange != 0)
         {
            _proxy.removeEventListener("enterFrame",__checkResponse);
         }
         InGameCursor.show();
         acceptDrag(null);
      }
      
      public static function __upDrag(param1:MouseEvent) : void
      {
         if(_isUpDrag)
         {
            __stopDrag(param1);
         }
      }
      
      private static function __stopDrag(param1:MouseEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc5_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         try
         {
            if(_passSelf && _changCardStateFun != null)
            {
               _changCardStateFun();
            }
            _loc6_ = _proxy.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
            _loc7_ = _proxy.stage;
            _loc2_ = true;
            InGameCursor.show();
            if(_loc7_)
            {
               _loc7_.removeEventListener("click",__stopDrag);
               _loc7_.removeEventListener("mouseUp",__upDrag);
            }
            _proxy.removeEventListener("click",__stopDrag);
            _proxy.removeEventListener("mouseUp",__upDrag);
            _proxy.removeEventListener("mouseWheel",__dispatchWheel);
            _proxy.removeEventListener("removedFromStage",__removeFromStage);
            if(_responseRectangle != null && _responseRange != 0)
            {
               _proxy.removeEventListener("enterFrame",__checkResponse);
            }
            param1.stopImmediatePropagation();
            if(_proxy.parent)
            {
               _proxy.parent.removeChild(_proxy);
            }
            _loc6_ = _loc6_.reverse();
            _loc9_ = false;
            var _loc12_:int = 0;
            var _loc11_:* = _loc6_;
            for each(var _loc8_ in _loc6_)
            {
               if(!_proxy.contains(_loc8_))
               {
                  _loc5_ = _loc8_;
                  _loc3_ = false;
                  while(_loc5_ && _loc5_ != _loc7_)
                  {
                     if(!_passSelf && _loc5_ == _source)
                     {
                        _dragEffect.action = "none";
                        _loc3_ = true;
                        break;
                     }
                     _loc4_ = _loc5_ as IAcceptDrag;
                     if(_loc4_)
                     {
                        if(_loc2_)
                        {
                           _loc4_.dragDrop(_dragEffect);
                           _loc9_ = true;
                           if(_throughAll == false)
                           {
                              _loc2_ = false;
                           }
                        }
                        if(!_isDraging)
                        {
                           _loc3_ = true;
                           break;
                        }
                     }
                     _loc5_ = _loc5_.parent;
                  }
                  if(!_loc3_)
                  {
                     continue;
                  }
                  break;
               }
            }
            if(!_isContinue || !_loc9_)
            {
               ObjectUtils.disposeAllChildren(_proxy);
            }
         }
         catch(e:Error)
         {
         }
         if(_source)
         {
            acceptDrag(null);
         }
      }
      
      public static function acceptDrag(param1:IAcceptDrag, param2:String = null) : void
      {
         _isDraging = false;
         var _loc4_:IDragable = _source;
         var _loc3_:DragEffect = _dragEffect;
         try
         {
            _loc3_.target = param1;
            if(param2)
            {
               _loc3_.action = param2;
            }
            _loc4_.dragStop(_loc3_);
         }
         catch(e:Error)
         {
         }
         if(!_isContinue)
         {
            _source = null;
            _dragEffect = null;
         }
      }
   }
}
