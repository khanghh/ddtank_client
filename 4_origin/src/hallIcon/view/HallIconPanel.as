package hallIcon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   
   public class HallIconPanel extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const BOTTOM:String = "bottom";
       
      
      private var _mainIcon:DisplayObject;
      
      private var _mainIconString:String;
      
      private var _hotNumBg:Bitmap;
      
      private var _hotNum:FilterFrameText;
      
      private var _iconArray:Array;
      
      private var _iconBox:HallIconBox;
      
      private var direction:String;
      
      private var vNum:int;
      
      private var hNum:int;
      
      private var WHSize:Array;
      
      private var tweenLiteMax:TweenLite;
      
      private var tweenLiteSmall:TweenLite;
      
      private var isExpand:Boolean;
      
      public function HallIconPanel(param1:String, param2:String = "left", param3:int = -1, param4:int = -1, param5:Array = null)
      {
         super();
         _mainIconString = param1;
         direction = param2;
         hNum = param3;
         vNum = param4;
         if(hNum == -1 && vNum == -1)
         {
            vNum = 1;
         }
         if(param5 == null)
         {
            param5 = [78,78];
         }
         WHSize = param5;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _mainIcon = ComponentFactory.Instance.creat(_mainIconString);
         if(_mainIcon is Sprite)
         {
            Sprite(_mainIcon).buttonMode = true;
            Sprite(_mainIcon).mouseChildren = false;
         }
         addChild(_mainIcon);
         _hotNumBg = ComponentFactory.Instance.creatBitmap("assets.hallIcon.hotNumBg");
         addChild(_hotNumBg);
         _hotNum = ComponentFactory.Instance.creatComponentByStylename("hallicon.hallIconPanel.hotNum");
         _hotNum.text = "0";
         addChild(_hotNum);
         updateHotNum();
         _iconArray = [];
         _iconBox = new HallIconBox();
         _iconBox.visible = false;
         addChild(_iconBox);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("click",__mainIconHandler);
      }
      
      public function addIcon(param1:DisplayObject, param2:String, param3:int = 0, param4:Boolean = false) : DisplayObject
      {
         _iconBox.addChild(param1);
         var _loc5_:Object = {};
         _loc5_.icon = param1;
         _loc5_.icontype = param2;
         _loc5_.orderId = param3;
         _loc5_.flag = param4;
         _iconArray.push(_loc5_);
         arrange();
         return param1;
      }
      
      public function getIconByType(param1:String) : DisplayObject
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _iconArray.length)
         {
            _loc3_ = _iconArray[_loc4_].icontype;
            if(_loc3_ == param1)
            {
               _loc2_ = _iconArray[_loc4_].icon;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function removeIconByType(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _iconArray.length)
         {
            _loc3_ = _iconArray[_loc5_].icontype;
            if(_loc3_ == param1)
            {
               _loc4_ = _iconArray[_loc5_].icon;
               _iconArray.splice(_loc5_,1);
               break;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            _loc2_ = _iconBox.getChildIndex(_loc4_);
            if(_loc2_ != -1)
            {
               _iconBox.removeChildAt(_loc2_);
            }
         }
         if(_loc4_)
         {
            ObjectUtils.disposeObject(_loc4_);
         }
         arrange();
      }
      
      public function arrange() : void
      {
         iconSortOn();
         updateIconsPos();
         if(isExpand)
         {
            updateDirectionPos();
         }
         updateHotNum();
      }
      
      private function updateIconsPos() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _iconArray.length)
         {
            _loc1_ = _iconArray[_loc2_].icon;
            if(hNum == -1)
            {
               _loc1_.x = _loc2_ * WHSize[0];
            }
            else
            {
               _loc1_.x = int(_loc2_ % hNum) * WHSize[0];
            }
            if(vNum == -1)
            {
               _loc1_.y = int(_loc2_ / hNum) * WHSize[1];
            }
            else
            {
               _loc1_.y = _loc2_ * WHSize[1];
            }
            _loc2_++;
         }
      }
      
      private function updateDirectionPos() : void
      {
         if(direction == "left")
         {
            _iconBox.x = -getIconSpriteWidth() - 10;
            _iconBox.y = -(getIconSpriteHeight() - WHSize[1]) / 2;
         }
         else if(direction == "right")
         {
            _iconBox.x = _mainIcon.x + _mainIcon.width + 10;
            _iconBox.y = -(getIconSpriteHeight() - WHSize[1]) / 2;
         }
         else if(direction == "bottom")
         {
            if(HallIconManager.instance.model.firstRechargeIsOpen && _iconArray[0].flag)
            {
               _iconBox.x = -350;
            }
            else
            {
               _iconBox.x = -(getIconSpriteWidth() - WHSize[0]);
            }
            _iconBox.y = _mainIcon.y + WHSize[1] + 5;
         }
      }
      
      public function iconSortOn() : void
      {
         if(_iconArray.length > 1)
         {
            _iconArray.sort(sortFunctin);
         }
      }
      
      private function sortFunctin(param1:Object, param2:Object) : Number
      {
         if(param1.orderId > param2.orderId)
         {
            return 1;
         }
         if(param1.orderId < param2.orderId)
         {
            return -1;
         }
         return 0;
      }
      
      public function expand(param1:Boolean) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(isExpand != param1 && _iconArray && _iconArray.length > 0)
         {
            isExpand = param1;
            if(isExpand)
            {
               _loc2_ = 0;
               _loc3_ = 0;
               if(direction == "left")
               {
                  _loc2_ = Number(-getIconSpriteWidth() - 10);
                  _loc3_ = Number(-(getIconSpriteHeight() - WHSize[1]) / 2);
               }
               else if(direction == "right")
               {
                  _loc2_ = Number(_mainIcon.x + _mainIcon.width + 10);
                  _loc3_ = Number(-(getIconSpriteHeight() - WHSize[1]) / 2);
               }
               else if(direction == "bottom")
               {
                  if(HallIconManager.instance.model.firstRechargeIsOpen && _iconArray[0].flag)
                  {
                     _loc2_ = Number(-350);
                  }
                  else
                  {
                     _loc2_ = Number(-(getIconSpriteWidth() - WHSize[0]));
                  }
                  _loc3_ = Number(_mainIcon.y + WHSize[1] + 5);
               }
               _iconBox.x = _mainIcon.x;
               _iconBox.y = 0;
               _iconBox.scaleX = 0;
               _iconBox.scaleY = 0;
               _iconBox.alpha = 0;
               _iconBox.visible = true;
               tweenLiteMax = TweenLite.to(_iconBox,0.2,{
                  "x":_loc2_,
                  "y":_loc3_,
                  "alpha":1,
                  "scaleX":1,
                  "scaleY":1,
                  "onComplete":tweenLiteMaxCloseComplete
               });
            }
            else
            {
               tweenLiteSmall = TweenLite.to(_iconBox,0.2,{
                  "x":_mainIcon.x,
                  "y":0,
                  "alpha":0,
                  "scaleX":0,
                  "scaleY":0,
                  "onComplete":tweenLiteSmallCloseComplete
               });
            }
         }
      }
      
      private function tweenLiteSmallCloseComplete() : void
      {
         killTweenLiteSmall();
         _iconBox.visible = false;
      }
      
      private function tweenLiteMaxCloseComplete() : void
      {
         killTweenLiteMax();
      }
      
      private function getIconSpriteWidth() : Number
      {
         var _loc1_:* = 0;
         if(_iconArray.length == 0)
         {
            _loc1_ = 0;
         }
         else if(hNum == -1)
         {
            _loc1_ = Number(_iconArray.length * WHSize[0]);
         }
         else if(_iconArray.length >= hNum)
         {
            _loc1_ = Number(hNum * WHSize[0]);
         }
         else
         {
            _loc1_ = Number(_iconArray.length * WHSize[0]);
         }
         return _loc1_;
      }
      
      private function getIconSpriteHeight() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         if(_iconArray.length == 0)
         {
            _loc2_ = 0;
         }
         else if(hNum == -1)
         {
            _loc2_ = Number(WHSize[1]);
         }
         else if(_iconArray.length >= hNum)
         {
            _loc1_ = _iconArray.length / hNum;
            if(_iconArray.length % hNum)
            {
               _loc1_ = _loc1_ + 1;
            }
            _loc2_ = Number(_loc1_ * WHSize[1]);
         }
         else
         {
            _loc2_ = Number(WHSize[1]);
         }
         return _loc2_;
      }
      
      public function removeChildrens() : void
      {
         _iconBox.removeChildren();
         _iconArray = [];
      }
      
      private function __mainIconHandler(param1:MouseEvent) : void
      {
         if(param1.target == _mainIcon)
         {
            SoundManager.instance.play("008");
            if(_iconArray && _iconArray.length > 0)
            {
               !!_iconBox.visible?expand(false):expand(true);
            }
         }
         else
         {
            expand(false);
         }
      }
      
      private function updateHotNum() : void
      {
         var _loc1_:Boolean = false;
         if(_iconArray && _iconArray.length > 0)
         {
            _loc1_ = true;
            _hotNum.text = _iconArray.length + "";
         }
         else
         {
            _hotNum.text = "0";
         }
         var _loc2_:* = _loc1_;
         _hotNum.visible = _loc2_;
         _hotNumBg.visible = _loc2_;
      }
      
      public function get mainIcon() : DisplayObject
      {
         return _mainIcon;
      }
      
      public function get count() : int
      {
         return _iconArray.length;
      }
      
      override public function get height() : Number
      {
         if(_mainIcon)
         {
            return _mainIcon.height;
         }
         return 0;
      }
      
      override public function get width() : Number
      {
         if(_mainIcon)
         {
            return _mainIcon.width;
         }
         return 0;
      }
      
      private function killTweenLiteMax() : void
      {
         if(!tweenLiteMax)
         {
            return;
         }
         tweenLiteMax.kill();
         tweenLiteMax = null;
      }
      
      private function killTweenLiteSmall() : void
      {
         if(!tweenLiteSmall)
         {
            return;
         }
         tweenLiteSmall.kill();
         tweenLiteSmall = null;
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("click",__mainIconHandler);
      }
      
      public function dispose() : void
      {
         killTweenLiteMax();
         killTweenLiteSmall();
         removeEvent();
         ObjectUtils.disposeObject(_mainIcon);
         _mainIcon = null;
         ObjectUtils.disposeObject(_hotNumBg);
         _hotNumBg = null;
         ObjectUtils.disposeObject(_hotNum);
         _hotNum = null;
         ObjectUtils.disposeObject(_iconBox);
         _iconBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _iconArray = null;
         WHSize = null;
         direction = null;
         _mainIconString = null;
         vNum = 0;
         hNum = 0;
      }
   }
}
