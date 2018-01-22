package newChickenBox.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   import newChickenBox.model.NewChickenBoxModel;
   
   public class NewChickenBoxView extends Sprite implements Disposeable
   {
      
      private static const NUM:int = 18;
       
      
      private var _model:NewChickenBoxModel;
      
      private var eyeItem:NewChickenBoxItem;
      
      private var frame:BaseAlerFrame;
      
      private var moveBackArr:Array;
      
      public function NewChickenBoxView()
      {
         super();
         _model = NewChickenBoxModel.instance;
         init();
      }
      
      private function init() : void
      {
         moveBackArr = [];
         if(_model.isShowAll)
         {
            getAllItem();
         }
         else
         {
            updataAllItem();
         }
      }
      
      public function getAllItem() : void
      {
         var _loc11_:int = 0;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc9_:int = Math.random() * 18;
         var _loc7_:int = getNum(_loc9_);
         _loc11_ = 0;
         while(_loc11_ < 18)
         {
            _loc2_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenStand") as MovieClip;
            _loc10_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenMove") as MovieClip;
            _loc5_ = "newChickenBox.itemPos" + _loc11_;
            _loc8_ = _model.templateIDList[_loc11_];
            _loc1_ = new Sprite();
            _loc1_.graphics.beginFill(16777215,0);
            _loc1_.graphics.drawRect(0,0,39,39);
            _loc1_.graphics.endFill();
            _loc4_ = new NewChickenBoxCell(_loc1_,_loc8_.info);
            if(_loc11_ == _loc9_ || _loc11_ == _loc7_)
            {
               _loc6_ = _loc10_;
               moveBackArr.push(_loc11_);
            }
            else
            {
               _loc6_ = _loc2_;
            }
            _loc3_ = new NewChickenBoxItem(_loc4_,_loc6_);
            _loc3_.info = _loc8_;
            _loc3_.updateCount();
            _loc3_.addEventListener("click",tackoverCard);
            _loc3_.position = _loc11_;
            PositionUtils.setPos(_loc3_,_loc5_);
            if(_model.itemList.length == 18)
            {
               _model.itemList[_loc11_].dispose();
               _model.itemList[_loc11_] = null;
               _model.itemList[_loc11_] = _loc3_;
            }
            else
            {
               _model.itemList.push(_loc3_);
            }
            addChild(_loc3_);
            _loc11_++;
         }
      }
      
      private function openAlertFrame(param1:NewChickenBoxItem) : BaseAlerFrame
      {
         var _loc3_:String = LanguageMgr.GetTranslation("newChickenBox.EagleEye.msg",_model.canEagleEyeCounts - _model.countEye,_model.eagleEyePrice[_model.countEye]);
         var _loc2_:SelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.selectBnt3");
         _loc2_.text = LanguageMgr.GetTranslation("newChickenBox.noAlert");
         _loc2_.addEventListener("click",noAlertEable);
         if(frame)
         {
            ObjectUtils.disposeObject(frame);
         }
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("newChickenBox.newChickenTitle"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         frame.addChild(_loc2_);
         frame.addEventListener("response",__onResponse);
         eyeItem = param1;
         return frame;
      }
      
      private function noAlertEable(param1:MouseEvent) : void
      {
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         if(_loc2_.selected)
         {
            _model.alertEye = false;
         }
         else
         {
            _model.alertEye = true;
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendChickenBoxUseEagleEye(eyeItem.position);
         }
      }
      
      private function openAlertFrame2(param1:NewChickenBoxItem) : BaseAlerFrame
      {
         var _loc3_:String = LanguageMgr.GetTranslation("newChickenBox.OpenCard.msg",_model.openCardPrice[_model.countTime]);
         var _loc2_:SelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.selectBnt2");
         _loc2_.text = LanguageMgr.GetTranslation("newChickenBox.noAlert");
         _loc2_.addEventListener("click",noAlertEable2);
         if(frame)
         {
            ObjectUtils.disposeObject(frame);
         }
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("newChickenBox.newChickenTitle"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         frame.addChild(_loc2_);
         frame.addEventListener("response",__onResponse2);
         eyeItem = param1;
         return frame;
      }
      
      private function noAlertEable2(param1:MouseEvent) : void
      {
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         if(_loc2_.selected)
         {
            _model.alertOpenCard = false;
         }
         else
         {
            _model.alertOpenCard = true;
         }
      }
      
      private function __onResponse2(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse2);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendChickenBoxTakeOverCard(eyeItem.info.Position);
         }
      }
      
      public function getItemEvent(param1:NewChickenBoxItem) : void
      {
         param1.addEventListener("click",tackoverCard);
      }
      
      public function removeItemEvent(param1:NewChickenBoxItem) : void
      {
         param1.removeEventListener("click",tackoverCard);
         param1.dispose();
      }
      
      public function tackoverCard(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:NewChickenBoxItem = param1.currentTarget as NewChickenBoxItem;
         var _loc4_:NewChickenBoxGoodsTempInfo = _loc2_.info;
         if(_model.canclickEnable && !_loc4_.IsSelected && (!_loc2_.cell.visible || _loc2_.cell.alpha < 0.9))
         {
            if(_model.clickEagleEye)
            {
               _loc3_ = _model.eagleEyePrice[_model.countEye];
               trace(_loc3_,_model.countEye);
               if(PlayerManager.Instance.Self.Money < _loc3_ && _model.freeEyeCount <= 0)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               if(_loc4_.IsSeeded)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newChickenBox.useEyeEnable"));
                  return;
               }
               if(_model.alertEye && _model.freeEyeCount <= 0)
               {
                  if(_model.countEye < _model.canEagleEyeCounts)
                  {
                     _model.dispatchEvent(new Event("mouseShapoff"));
                     openAlertFrame(_loc2_);
                  }
                  else
                  {
                     SocketManager.Instance.out.sendChickenBoxUseEagleEye(_loc2_.position);
                  }
               }
               else
               {
                  SocketManager.Instance.out.sendChickenBoxUseEagleEye(_loc2_.position);
               }
            }
            else
            {
               _loc3_ = _model.openCardPrice[_model.countTime];
               trace(_loc3_,_model.countTime);
               if(PlayerManager.Instance.Self.Money < _loc3_ && _model.freeOpenCardCount <= 0)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               if(_model.alertOpenCard && _model.freeOpenCardCount <= 0)
               {
                  openAlertFrame2(_loc2_);
               }
               else
               {
                  SocketManager.Instance.out.sendChickenBoxTakeOverCard(_loc2_.info.Position);
               }
            }
         }
      }
      
      private function getNum(param1:int) : int
      {
         var _loc2_:int = Math.random() * 18;
         if(_loc2_ == param1)
         {
            getNum(param1);
         }
         return _loc2_;
      }
      
      public function updataAllItem() : void
      {
         var _loc10_:int = 0;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc9_:int = Math.random() * 18;
         var _loc7_:int = getNum(_loc9_);
         _loc10_ = 0;
         while(_loc10_ < _model.templateIDList.length)
         {
            _loc5_ = "newChickenBox.itemPos" + _loc10_;
            _loc8_ = _model.templateIDList[_loc10_];
            _loc2_ = new Sprite();
            _loc2_.graphics.beginFill(16777215,0);
            _loc2_.graphics.drawRect(0,0,39,39);
            _loc2_.graphics.endFill();
            _loc1_ = _loc8_.IsSelected || _loc8_.IsSeeded?_loc8_.info:null;
            _loc4_ = new NewChickenBoxCell(_loc2_,_loc1_);
            if((_loc10_ == _loc9_ || _loc10_ == _loc7_) && _loc8_.IsSelected)
            {
               _loc6_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenMove") as MovieClip;
            }
            else if(_loc8_.IsSelected)
            {
               _loc6_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenStand") as MovieClip;
            }
            else if(_loc8_.IsSeeded)
            {
               _loc6_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenBack") as MovieClip;
               _loc4_.visible = true;
               _loc4_.alpha = 0.5;
            }
            else
            {
               _loc6_ = ClassUtils.CreatInstance("asset.newChickenBox.chickenBack") as MovieClip;
               _loc4_.visible = false;
            }
            _loc3_ = new NewChickenBoxItem(_loc4_,_loc6_);
            _loc3_.info = _loc8_;
            _loc3_.updateCount();
            _loc3_.countTextShowIf();
            _loc3_.addEventListener("click",tackoverCard);
            _loc3_.position = _loc10_;
            PositionUtils.setPos(_loc3_,_loc5_);
            if(_model.itemList.length == 18)
            {
               _model.itemList[_loc10_].dispose();
               _model.itemList[_loc10_] = null;
               _model.itemList[_loc10_] = _loc3_;
            }
            else
            {
               _model.itemList.push(_loc3_);
            }
            addChild(_loc3_);
            _loc10_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(frame)
         {
            frame.removeEventListener("response",__onResponse);
            frame.dispose();
         }
         _loc2_ = 0;
         while(_loc2_ < _model.templateIDList.length)
         {
            _loc1_ = _model.itemList[_loc2_] as NewChickenBoxItem;
            _loc1_.dispose();
            _loc1_ = null;
            _loc2_++;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
