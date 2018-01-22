package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemRightView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _titleTxt1:FilterFrameText;
      
      private var _honorTxt1:TotemRightViewIconTxtCell;
      
      private var _expTxt1:TotemRightViewIconTxtCell;
      
      private var _titleTxt2:FilterFrameText;
      
      private var _honorTxt2:TotemRightViewIconTxtCell;
      
      private var _expTxt2:TotemRightViewIconTxtCell;
      
      private var _titleTxt3:FilterFrameText;
      
      private var _propertyList:Vector.<TotemRightViewTxtTxtCell>;
      
      private var _tipTxt:FilterFrameText;
      
      private var _honorUpIcon:HonorUpIcon;
      
      private var _nextInfo:TotemDataVo;
      
      private var _totemRightViewIconTxtDragonBoatCell:TotemRightViewIconTxtDragonBoatCell;
      
      private var _totemSignTxtCell:TotemSignTxtCell;
      
      public function TotemRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.rightView.bg");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.lvTxt");
         _titleTxt1 = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.titleTxt1");
         _titleTxt1.text = LanguageMgr.GetTranslation("ddt.totem.rightView.titleTxt1");
         _honorTxt1 = ComponentFactory.Instance.creatCustomObject("TotemRightViewIconTxtCell.honor1");
         _expTxt1 = ComponentFactory.Instance.creatCustomObject("TotemRightViewIconTxtCell.exp1");
         _titleTxt2 = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.titleTxt2");
         _titleTxt2.text = LanguageMgr.GetTranslation("ddt.totem.rightView.titleTxt2");
         _honorTxt2 = ComponentFactory.Instance.creatCustomObject("TotemRightViewIconTxtCell.honor2");
         _expTxt2 = ComponentFactory.Instance.creatCustomObject("TotemRightViewIconTxtCell.exp2");
         _titleTxt3 = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.titleTxt3");
         _titleTxt3.text = LanguageMgr.GetTranslation("ddt.totem.rightView.titleTxt3");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.tipTxt");
         _tipTxt.text = LanguageMgr.GetTranslation("ddt.totem.rightView.tipTxt");
         _honorUpIcon = ComponentFactory.Instance.creatCustomObject("totem.honorUpIcon");
         _totemSignTxtCell = ComponentFactory.Instance.creatCustomObject("totem.totemSignTxtCell");
         addChild(_bg);
         addChild(_lvTxt);
         addChild(_titleTxt1);
         addChild(_honorTxt1);
         addChild(_expTxt1);
         addChild(_titleTxt2);
         addChild(_honorTxt2);
         addChild(_expTxt2);
         addChild(_titleTxt3);
         addChild(_tipTxt);
         _propertyList = new Vector.<TotemRightViewTxtTxtCell>();
         _loc2_ = 1;
         while(_loc2_ <= 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TotemRightViewTxtTxtCell" + _loc2_);
            _loc1_.show(_loc2_);
            _loc1_.x = 44 + (_loc2_ - 1) % 2 * 110;
            _loc1_.y = 323 + int((_loc2_ - 1) / 2) * 21;
            addChild(_loc1_);
            _propertyList.push(_loc1_);
            _loc2_++;
         }
         addChild(_honorUpIcon);
         addChild(_totemSignTxtCell);
         _honorTxt1.show(2);
         _expTxt1.show(1);
         _honorTxt2.show(2);
         _expTxt2.show(1);
         refreshView();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",propertyChangeHandler);
      }
      
      public function refreshView() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         _totemSignTxtCell.updateData();
         var _loc3_:int = TotemManager.instance.getTotemPointLevel(PlayerManager.Instance.Self.totemId);
         _lvTxt.text = LanguageMgr.GetTranslation("ddt.totem.rightView.lvTxt",TotemManager.instance.getCurrentLv(_loc3_));
         _nextInfo = TotemManager.instance.getNextInfoByLevel(_loc3_);
         if(_nextInfo)
         {
            _honorTxt1.refresh(_nextInfo.ConsumeHonor);
            _expTxt1.refresh(_nextInfo.ConsumeExp);
            _loc1_ = Math.round(_nextInfo.ConsumeExp * ServerConfigManager.instance.totemSignDiscount);
            if(DragonBoatManager.instance.isBuildEnd)
            {
               _expTxt1.rawTextLine();
               if(!_totemRightViewIconTxtDragonBoatCell)
               {
                  _totemRightViewIconTxtDragonBoatCell = ComponentFactory.Instance.creatCustomObject("totem.rightView.iconCellDragonBoat");
                  addChild(_totemRightViewIconTxtDragonBoatCell);
               }
               _totemRightViewIconTxtDragonBoatCell.refresh(_nextInfo.DiscountMoney);
               _loc1_ = Math.round(_nextInfo.DiscountMoney * (ServerConfigManager.instance.totemSignDiscount / 100));
            }
            else
            {
               _expTxt1.clearTextLine();
            }
         }
         else
         {
            _honorTxt1.refresh(0);
            _expTxt1.refresh(0);
         }
         refreshHonorTxt();
         refreshGPTxt();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _propertyList[_loc2_].refresh();
            _loc2_++;
         }
      }
      
      private function refreshHonorTxt() : void
      {
         var _loc2_:Boolean = false;
         if(_nextInfo && PlayerManager.Instance.Self.myHonor < _nextInfo.ConsumeHonor)
         {
            _loc2_ = true;
         }
         var _loc1_:int = PlayerManager.Instance.Self.myHonor;
         _honorTxt2.refresh(PlayerManager.Instance.Self.myHonor,_loc2_);
      }
      
      private function refreshGPTxt() : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(_nextInfo)
         {
            _loc4_ = false;
            _loc3_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
            if(DragonBoatManager.instance.isBuildEnd)
            {
               _loc2_ = Math.round(_nextInfo.DiscountMoney * (ServerConfigManager.instance.totemSignDiscount / 100));
               if(_loc3_ > _loc2_)
               {
                  _loc3_ = _loc2_;
               }
               if(_nextInfo && PlayerManager.Instance.Self.Money + _loc3_ < _nextInfo.DiscountMoney)
               {
                  _loc4_ = true;
               }
            }
            else
            {
               _loc1_ = Math.round(_nextInfo.ConsumeExp * (ServerConfigManager.instance.totemSignDiscount / 100));
               if(_loc3_ > _loc1_)
               {
                  _loc3_ = _loc1_;
               }
               if(_nextInfo && PlayerManager.Instance.Self.Money + _loc3_ < _nextInfo.ConsumeExp)
               {
                  _loc4_ = true;
               }
            }
            _expTxt2.refresh(PlayerManager.Instance.Self.Money,_loc4_);
         }
         else
         {
            _expTxt2.refresh(PlayerManager.Instance.Self.Money,false);
         }
      }
      
      private function propertyChangeHandler(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["myHonor"])
         {
            refreshHonorTxt();
         }
         if(param1.changedProperties["GP"])
         {
            refreshGPTxt();
         }
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",propertyChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_totemSignTxtCell);
         ObjectUtils.disposeObject(_totemSignTxtCell);
         _totemSignTxtCell = null;
         ObjectUtils.disposeAllChildren(this);
         _nextInfo = null;
         _bg = null;
         _lvTxt = null;
         _titleTxt1 = null;
         _honorTxt1 = null;
         _expTxt1 = null;
         _titleTxt2 = null;
         _honorTxt2 = null;
         _expTxt2 = null;
         _titleTxt3 = null;
         _tipTxt = null;
         _propertyList = null;
         _honorUpIcon = null;
         _totemRightViewIconTxtDragonBoatCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
