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
      
      public static function startDrag(source:IDragable, data:Object, image:DisplayObject, stageX:int, stageY:int, action:String = "none", mouseMask:Boolean = true, mouseDown:Boolean = false, throughAll:Boolean = false, passSelf:Boolean = false, isUpDrag:Boolean = false, responseRetangle:DisplayObject = null, responseRange:int = 0, isContinue:Boolean = false) : Boolean
      {
         if(!_isDraging && image)
         {
            _responseRectangle = responseRetangle;
            _responseRange = responseRange;
            _isContinue = isContinue;
            _passSelf = passSelf;
            _isUpDrag = isUpDrag;
            _isDraging = true;
            _proxy = new Sprite();
            image.x = -image.width / 2;
            image.y = -image.height / 2;
            _proxy.addChild(image);
            InGameCursor.hide();
            _proxy.x = stageX;
            _proxy.y = stageY;
            _proxy.mouseEnabled = mouseMask;
            _proxy.mouseChildren = false;
            _proxy.startDrag();
            _throughAll = throughAll;
            _dragEffect = new DragEffect(source.getSource(),data,action);
            _source = source;
            LayerManager.Instance.addToLayer(_proxy,1);
            if(mouseMask)
            {
               _proxy.addEventListener("click",__stopDrag);
               _proxy.addEventListener("mouseUp",__upDrag);
               _proxy.addEventListener("mouseWheel",__dispatchWheel);
            }
            else
            {
               if(!mouseDown)
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
      
      protected static function __checkResponse(event:Event) : void
      {
         var top:Boolean = _proxy.stage.mouseY > _responseRectangle.y && _proxy.stage.mouseY < _responseRectangle.y + _responseRange;
         var bottom:Boolean = _proxy.stage.mouseY > _responseRectangle.y + _responseRectangle.height - _responseRange && _proxy.stage.mouseY < _responseRectangle.y + _responseRectangle.height;
         var bx:Boolean = _proxy.stage.mouseX > _responseRectangle.x && _proxy.stage.mouseX < _responseRectangle.x + _responseRectangle.width;
         if(top && bx)
         {
            _responseRectangle.dispatchEvent(new Event("dragInRangeTop"));
         }
         else if(bottom && bx)
         {
            _responseRectangle.dispatchEvent(new Event("dragOutRangeButtom"));
         }
      }
      
      public static function ListenWheelEvent(Fun:Function) : void
      {
         _wheelFun = Fun;
      }
      
      public static function removeListenWheelEvent() : void
      {
         _wheelFun = null;
         _changCardStateFun = null;
      }
      
      private static function __dispatchWheel(event:MouseEvent) : void
      {
         if(_passSelf && _wheelFun != null)
         {
            _wheelFun(event);
         }
      }
      
      public static function changeCardState(Fun:Function) : void
      {
         _changCardStateFun = Fun;
      }
      
      private static function __stageMouseDown(e:Event) : void
      {
         e.stopImmediatePropagation();
         if(_proxy.stage)
         {
            _proxy.stage.removeEventListener("mouseDown",__stageMouseDown,true);
         }
      }
      
      private static function __removeFromStage(event:Event) : void
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
      
      public static function __upDrag(event:MouseEvent) : void
      {
         if(_isUpDrag)
         {
            __stopDrag(event);
         }
      }
      
      private static function __stopDrag(evt:MouseEvent) : void
      {
         var list:* = null;
         var _stage:* = null;
         var ex:Boolean = false;
         var isDragdrop:Boolean = false;
         var temp:* = null;
         var flag:Boolean = false;
         var ad:* = null;
         try
         {
            if(_passSelf && _changCardStateFun != null)
            {
               _changCardStateFun();
            }
            list = _proxy.stage.getObjectsUnderPoint(new Point(evt.stageX,evt.stageY));
            _stage = _proxy.stage;
            ex = true;
            InGameCursor.show();
            if(_stage)
            {
               _stage.removeEventListener("click",__stopDrag);
               _stage.removeEventListener("mouseUp",__upDrag);
            }
            _proxy.removeEventListener("click",__stopDrag);
            _proxy.removeEventListener("mouseUp",__upDrag);
            _proxy.removeEventListener("mouseWheel",__dispatchWheel);
            _proxy.removeEventListener("removedFromStage",__removeFromStage);
            if(_responseRectangle != null && _responseRange != 0)
            {
               _proxy.removeEventListener("enterFrame",__checkResponse);
            }
            evt.stopImmediatePropagation();
            if(_proxy.parent)
            {
               _proxy.parent.removeChild(_proxy);
            }
            list = list.reverse();
            isDragdrop = false;
            var _loc12_:int = 0;
            var _loc11_:* = list;
            for each(var ds in list)
            {
               if(!_proxy.contains(ds))
               {
                  temp = ds;
                  flag = false;
                  while(temp && temp != _stage)
                  {
                     if(!_passSelf && temp == _source)
                     {
                        _dragEffect.action = "none";
                        flag = true;
                        break;
                     }
                     ad = temp as IAcceptDrag;
                     if(ad)
                     {
                        if(ex)
                        {
                           ad.dragDrop(_dragEffect);
                           isDragdrop = true;
                           if(_throughAll == false)
                           {
                              ex = false;
                           }
                        }
                        if(!_isDraging)
                        {
                           flag = true;
                           break;
                        }
                     }
                     temp = temp.parent;
                  }
                  if(!flag)
                  {
                     continue;
                  }
                  break;
               }
            }
            if(!_isContinue || !isDragdrop)
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
      
      public static function acceptDrag(target:IAcceptDrag, action:String = null) : void
      {
         _isDraging = false;
         var source:IDragable = _source;
         var effect:DragEffect = _dragEffect;
         try
         {
            effect.target = target;
            if(action)
            {
               effect.action = action;
            }
            source.dragStop(effect);
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
