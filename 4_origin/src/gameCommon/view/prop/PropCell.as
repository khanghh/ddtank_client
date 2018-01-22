package gameCommon.view.prop
{
   import bagAndInfo.cell.DragEffect;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import ddt.manager.BitmapManager;
   import ddt.manager.DragManager;
   import ddt.manager.SharedManager;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   
   public class PropCell extends Sprite implements Disposeable, ITipedDisplay, IDragable, IAcceptDrag
   {
       
      
      protected var _x:int;
      
      protected var _y:int;
      
      protected var _enabled:Boolean = true;
      
      protected var _info:PropInfo;
      
      protected var _asset:DisplayObject;
      
      protected var _isExist:Boolean;
      
      protected var _back:DisplayObject;
      
      protected var _fore:DisplayObject;
      
      protected var _shortcutKey:String;
      
      protected var _shortcutKeyShape:DisplayObject;
      
      protected var _tipInfo:ToolPropInfo;
      
      protected var _tweenMax:TweenLite;
      
      protected var _localVisible:Boolean = true;
      
      protected var _mode:int;
      
      protected var _bitmapMgr:BitmapManager;
      
      private var _allowDrag:Boolean;
      
      protected var _grayFilters:Array;
      
      private var _isUsed:Boolean;
      
      public function PropCell(param1:String = null, param2:int = -1, param3:Boolean = false)
      {
         super();
         _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
         _shortcutKey = param1;
         _grayFilters = ComponentFactory.Instance.creatFilters("grayFilter");
         _mode = param2;
         mouseChildren = false;
         _allowDrag = param3;
         configUI();
         addEvent();
      }
      
      public function get shortcutKey() : String
      {
         return _shortcutKey;
      }
      
      public function get isUsed() : Boolean
      {
         return _isUsed;
      }
      
      public function set isUsed(param1:Boolean) : void
      {
         _isUsed = param1;
      }
      
      public function dragStart() : void
      {
         if(_info && _allowDrag)
         {
            if(_enabled)
            {
               DragManager.startDrag(this,_info,_asset,stage.mouseX,stage.mouseY,"none",false,true,false,false,true);
            }
            else
            {
               _asset.filters = _grayFilters;
               DragManager.startDrag(this,_info,_asset,stage.mouseX,stage.mouseY,"none",false,true,false,false,true);
            }
         }
      }
      
      public function setGrayFilter() : void
      {
         filters = _grayFilters;
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         KeyboardManager.getInstance().isStopDispatching = false;
         if(param1.target == null || param1.target is PropCell == false)
         {
            info = _info;
         }
         var _loc3_:PropCell = param1.target as PropCell;
         var _loc2_:PropInfo = _loc3_.info;
         var _loc4_:Boolean = _loc3_._enabled;
         var _loc5_:int = SharedManager.Instance.GameKeySets[_loc3_.shortcutKey];
         _loc3_.info = info;
         SharedManager.Instance.GameKeySets[_loc3_.shortcutKey] = SharedManager.Instance.GameKeySets[this.shortcutKey];
         info = _loc2_;
         SharedManager.Instance.GameKeySets[this.shortcutKey] = _loc5_;
         SharedManager.Instance.save();
         _loc3_.enabled = enabled;
         this.enabled = _loc4_;
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         if(_allowDrag)
         {
            param1.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 20;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 20;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "core.ToolPropTips";
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
      
      protected function configUI() : void
      {
         _back = _bitmapMgr.creatBitmapShape("asset.game.prop.ItemBack",null,false,true);
         addChild(_back);
         _fore = _bitmapMgr.creatBitmapShape("asset.game.prop.ItemFore",null,false,true);
         var _loc1_:int = 2;
         _fore.y = _loc1_;
         _fore.x = _loc1_;
         addChild(_fore);
         if(_shortcutKey != null)
         {
            _shortcutKeyShape = ComponentFactory.Instance.creatBitmap("asset.game.prop.ShortcutKey" + _shortcutKey);
            Bitmap(_shortcutKeyShape).smoothing = true;
            _shortcutKeyShape.y = -2;
            addChild(_shortcutKeyShape);
         }
         _tipInfo = new ToolPropInfo();
         _tipInfo.showThew = true;
         drawLayer();
      }
      
      protected function drawLayer() : void
      {
         if(_shortcutKey == null)
         {
            return;
         }
         if(_mode == 2)
         {
            _shortcutKeyShape.x = 36 - _shortcutKeyShape.width;
         }
         else
         {
            _shortcutKeyShape.x = 0;
         }
      }
      
      protected function addEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      protected function __mouseOut(param1:MouseEvent) : void
      {
         x = _x;
         y = _y;
         scaleY = 1;
         scaleX = 1;
         if(_shortcutKey != null)
         {
            var _loc2_:int = 1;
            _shortcutKeyShape.scaleY = _loc2_;
            _shortcutKeyShape.scaleX = _loc2_;
         }
         if(_tweenMax)
         {
            _tweenMax.pause();
         }
         if(_enabled)
         {
            filters = null;
         }
         else
         {
            filters = _grayFilters;
         }
      }
      
      protected function __mouseOver(param1:MouseEvent) : void
      {
         if(_info != null)
         {
            if(_shortcutKey != null)
            {
               var _loc2_:* = 0.9;
               _shortcutKeyShape.scaleY = _loc2_;
               _shortcutKeyShape.scaleX = _loc2_;
            }
            x = _x - 3.6;
            y = _y - 3.6;
            scaleY = 1.2;
            scaleX = 1.2;
            if(enabled)
            {
               if(_tweenMax == null)
               {
                  _tweenMax = TweenMax.to(this,0.5,{
                     "repeat":-1,
                     "yoyo":true,
                     "glowFilter":{
                        "color":16777011,
                        "alpha":1,
                        "blurX":4,
                        "blurY":4,
                        "strength":3
                     }
                  });
               }
               _tweenMax.play();
            }
            if(parent)
            {
               parent.setChildIndex(this,parent.numChildren - 1);
            }
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      public function get info() : PropInfo
      {
         return _info;
      }
      
      public function setMode(param1:int) : void
      {
         _mode = param1;
         drawLayer();
      }
      
      public function set info(param1:PropInfo) : void
      {
         var _loc2_:* = null;
         ShowTipManager.Instance.removeTip(this);
         _info = param1;
         var _loc3_:DisplayObject = _asset;
         if(_info != null)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop" + _info.Template.Pic + "Asset");
            if(_loc2_)
            {
               _loc2_.smoothing = true;
               var _loc4_:int = 1;
               _loc2_.y = _loc4_;
               _loc2_.x = _loc4_;
               _loc4_ = 35;
               _loc2_.height = _loc4_;
               _loc2_.width = _loc4_;
               addChildAt(_loc2_,getChildIndex(_fore));
            }
            _asset = _loc2_;
            _tipInfo.info = _info.Template;
            _tipInfo.shortcutKey = _shortcutKey;
            ShowTipManager.Instance.addTip(this);
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
         if(_loc3_ != null)
         {
            ObjectUtils.disposeObject(_loc3_);
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enabled != param1)
         {
            _enabled = param1;
            if(!_enabled)
            {
               filters = _grayFilters;
            }
            else
            {
               filters = null;
            }
         }
      }
      
      public function get isExist() : Boolean
      {
         return _isExist;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         _isExist = param1;
      }
      
      public function setPossiton(param1:int, param2:int) : void
      {
         _x = param1;
         _y = param2;
         this.x = _x;
         this.y = _y;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ShowTipManager.Instance.removeTip(this);
         filters = null;
         if(_tweenMax)
         {
            _tweenMax.kill();
         }
         _tweenMax = null;
         ObjectUtils.disposeObject(_asset);
         _asset = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_fore);
         _fore = null;
         ObjectUtils.disposeObject(_shortcutKeyShape);
         _shortcutKeyShape = null;
         ObjectUtils.disposeObject(_bitmapMgr);
         _bitmapMgr = null;
         TweenLite.killTweensOf(this);
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function useProp() : void
      {
         if(_localVisible)
         {
            dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function get localVisible() : Boolean
      {
         return _localVisible;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(_localVisible != param1)
         {
            _localVisible = param1;
         }
      }
      
      public function set back(param1:DisplayObject) : void
      {
         _back = param1;
      }
   }
}
