package flowerGiving.components
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFormat;
   import flowerGiving.data.FlowerRankInfo;
   import vip.VipController;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class FlowerRankItem extends Sprite implements Disposeable
   {
       
      
      private var _sprite:Sprite;
      
      private var _backOverBit:Bitmap;
      
      private var _topThreeIcon:ScaleFrameImage;
      
      private var _placeTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _baseIcon:Image;
      
      private var _superIcon:Image;
      
      private var _info:FlowerRankInfo;
      
      private var _baseTip:GoodTipInfo;
      
      private var _superTip:GoodTipInfo;
      
      public function FlowerRankItem()
      {
         super();
         initData();
         initView();
         addEvents();
      }
      
      private function initData() : void
      {
         _baseTip = new GoodTipInfo();
         var _loc2_:ItemTemplateInfo = new ItemTemplateInfo();
         _loc2_.Quality = 4;
         _loc2_.CategoryID = 11;
         _loc2_.Name = "Quà Cơ Bản";
         _loc2_.Description = "一些描述";
         _baseTip.itemInfo = _loc2_;
         _superTip = new GoodTipInfo();
         var _loc1_:ItemTemplateInfo = new ItemTemplateInfo();
         _loc1_.Quality = 4;
         _loc1_.CategoryID = 11;
         _loc1_.Name = "Túi Quà Siêu Cấp";
         _loc1_.Description = "一些描述";
         _superTip.itemInfo = _loc1_;
      }
      
      private function initView() : void
      {
         _backOverBit = ComponentFactory.Instance.creat("flowerGiving.rankView.mouseOver");
         _backOverBit.visible = false;
         _sprite = new Sprite();
         _sprite.graphics.beginFill(0,0);
         _sprite.graphics.drawRect(0,0,_backOverBit.width,_backOverBit.height);
         _sprite.graphics.endFill();
         _sprite.x = _backOverBit.x;
         _sprite.y = _backOverBit.y;
         addChild(_sprite);
         _topThreeIcon = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.topThree");
         addChild(_topThreeIcon);
         _topThreeIcon.visible = false;
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.rankVeiw.placeTxt");
         _placeTxt.text = "4th";
         addChild(_placeTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.rankVeiw.nameTxt");
         _nameTxt.text = "小妹也带刀";
         addChild(_nameTxt);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.rankVeiw.numTxt");
         _numTxt.text = "10000";
         addChild(_numTxt);
         _baseIcon = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.rewardSmallIcon");
         PositionUtils.setPos(_baseIcon,"flowerGiving.baseIconPos");
         _baseIcon.tipStyle = "core.GoodsTip";
         _baseIcon.tipDirctions = "1,3";
         _baseIcon.tipData = _baseTip;
         addChild(_baseIcon);
         _superIcon = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.rewardSmallIcon");
         PositionUtils.setPos(_superIcon,"flowerGiving.superIconPos");
         _superIcon.tipStyle = "core.GoodsTip";
         _superIcon.tipDirctions = "1,3";
         _superIcon.tipData = _superTip;
         addChild(_superIcon);
         addChild(_backOverBit);
      }
      
      private function addEvents() : void
      {
         addEventListener("rollOver",__onOverHanlder);
         addEventListener("rollOut",__onOutHandler);
      }
      
      protected function __onOutHandler(param1:MouseEvent) : void
      {
         _backOverBit.visible = false;
      }
      
      protected function __onOverHanlder(param1:MouseEvent) : void
      {
         _backOverBit.visible = true;
      }
      
      public function set info(param1:FlowerRankInfo) : void
      {
         _info = param1;
         setRankNum(_info.place);
         addNickName();
         _numTxt.text = _info.num + "";
         addTips();
      }
      
      private function addNickName() : void
      {
         var _loc1_:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !_info.isVIP;
         if(_info.isVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            _loc1_ = new TextFormat();
            _loc1_.align = "center";
            _loc1_.bold = true;
            _vipName.textField.defaultTextFormat = _loc1_;
            _vipName.textSize = 16;
            _vipName.textField.width = _nameTxt.width;
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.mouseEnabled = true;
            _vipName.buttonMode = true;
            _vipName.htmlText = LanguageMgr.GetTranslation("ddt.flowerRankItem.vipName.txtStyle",_info.name);
            _vipName.addEventListener("click",__vipNameClick_Handler);
            addChild(_vipName);
         }
         else
         {
            _nameTxt.mouseEnabled = true;
            _nameTxt.htmlText = LanguageMgr.GetTranslation("ddt.flowerRankItem.vipName.txtStyle",_info.name);
            _nameTxt.addEventListener("link",__textClickHandler);
         }
      }
      
      private function __textClickHandler(param1:TextEvent) : void
      {
         openPlayerInfoFrame();
      }
      
      private function __vipNameClick_Handler(param1:MouseEvent) : void
      {
         openPlayerInfoFrame();
      }
      
      private function openPlayerInfoFrame() : void
      {
         PlayerInfoViewControl.viewByNickName(_info.name);
         PlayerInfoViewControl.isOpenFromBag = false;
      }
      
      private function setRankNum(param1:int) : void
      {
         if(param1 <= 3)
         {
            _placeTxt.visible = false;
            _topThreeIcon.visible = true;
            _topThreeIcon.setFrame(param1);
         }
         else
         {
            _placeTxt.visible = true;
            _topThreeIcon.visible = false;
            _placeTxt.text = param1 + "th";
         }
      }
      
      private function addTips() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _baseTip.itemInfo.Description = "";
         _superTip.itemInfo.Description = "";
         _loc3_ = 0;
         while(_loc3_ <= _info.rewardVec.length - 1)
         {
            _loc1_ = _info.rewardVec[_loc3_];
            _loc2_ = new InventoryItemInfo();
            _loc2_.TemplateID = _loc1_.templateId;
            ItemManager.fill(_loc2_);
            if(_loc1_.rewardType == 0)
            {
               if(_baseTip.itemInfo.Description != "")
               {
                  _baseTip.itemInfo.Description = _baseTip.itemInfo.Description + "、";
               }
               _baseTip.itemInfo.Description = _baseTip.itemInfo.Description + (_loc2_.Name + "x" + _loc1_.count);
               _baseIcon.tipData = _baseTip;
            }
            else
            {
               if(_superTip.itemInfo.Description != "")
               {
                  _superTip.itemInfo.Description = _superTip.itemInfo.Description + "、";
               }
               _superTip.itemInfo.Description = _superTip.itemInfo.Description + (_loc2_.Name + "x" + _loc1_.count);
               _superIcon.tipData = _superTip;
            }
            _loc3_++;
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("rollOver",__onOverHanlder);
         removeEventListener("rollOut",__onOutHandler);
         if(_vipName)
         {
            _vipName.removeEventListener("click",__vipNameClick_Handler);
         }
         if(_nameTxt)
         {
            _nameTxt.removeEventListener("link",__textClickHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_backOverBit);
         _backOverBit = null;
         ObjectUtils.disposeObject(_placeTxt);
         _placeTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_topThreeIcon);
         _topThreeIcon = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_baseIcon);
         _baseIcon = null;
         ObjectUtils.disposeObject(_superIcon);
         _superIcon = null;
      }
   }
}
