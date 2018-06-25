package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.model.BeadInfo;
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetInfoManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import pet.data.PetTemplateInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class GiftBagItem extends Sprite implements Disposeable
   {
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
       
      
      private var _type:int;
      
      private var _index:int;
      
      private var _bg:Bitmap;
      
      private var _giftBagIcon:Bitmap;
      
      private var _tipSprite:Component;
      
      private var _baseTip:GoodTipInfo;
      
      private var _cell:BagCell;
      
      public function GiftBagItem(type:int, index:int)
      {
         super();
         _type = type;
         _index = index == 0?1:index;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("wonderful.accumulative.itemBG");
         addChild(_bg);
      }
      
      private function initGiftView() : void
      {
         _tipSprite = new Component();
         addChild(_tipSprite);
         _giftBagIcon = ComponentFactory.Instance.creat("wonderfulactivity.giftBag" + _index);
         _tipSprite.addChild(_giftBagIcon);
         _giftBagIcon.scaleX = 0.7;
         _giftBagIcon.scaleY = 0.7;
         _giftBagIcon.smoothing = true;
         _baseTip = new GoodTipInfo();
         var info:ItemTemplateInfo = new ItemTemplateInfo();
         info.Quality = 4;
         info.CategoryID = 11;
         info.Name = _type == 0?LanguageMgr.GetTranslation("returnActivity.rechargeGiftName"):LanguageMgr.GetTranslation("returnActivity.consumeGiftName");
         _baseTip.itemInfo = info;
         _tipSprite.width = _giftBagIcon.width;
         _tipSprite.height = _giftBagIcon.height;
         _tipSprite.tipStyle = "core.GoodsTip";
         _tipSprite.tipDirctions = "0";
         _tipSprite.tipData = _baseTip;
      }
      
      public function set selected(flag:Boolean) : void
      {
         if(flag)
         {
            if(_giftBagIcon)
            {
               TweenLite.to(_giftBagIcon,0.25,{
                  "x":-6,
                  "y":-5,
                  "scaleX":0.85,
                  "scaleY":0.85,
                  "ease":Quad.easeOut
               });
               _giftBagIcon.filters = MOUSE_ON_GLOW_FILTER;
            }
            else
            {
               TweenLite.to(_cell,0.25,{
                  "x":-2,
                  "y":-2,
                  "scaleX":0.85,
                  "scaleY":0.85,
                  "ease":Quad.easeOut
               });
               _cell.filters = MOUSE_ON_GLOW_FILTER;
            }
         }
         else if(_giftBagIcon)
         {
            TweenLite.to(_giftBagIcon,0.25,{
               "x":0,
               "y":0,
               "scaleX":0.7,
               "scaleY":0.7,
               "ease":Quad.easeOut
            });
            _giftBagIcon.filters = null;
         }
         else
         {
            TweenLite.to(_cell,0.25,{
               "x":3,
               "y":3,
               "scaleX":0.7,
               "scaleY":0.7,
               "ease":Quad.easeOut
            });
            _cell.filters = null;
         }
      }
      
      public function setData(giftBagVec:Vector.<GiftRewardInfo>) : void
      {
         updateGiftView(giftBagVec);
      }
      
      private function updateGoodsView(goods:GiftRewardInfo) : void
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = goods.templateId;
         info = ItemManager.fill(info);
         info.ValidDate = goods.validDate;
         info.Count = goods.count;
         info.IsBinds = goods.isBind;
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,0);
         shape.graphics.drawRect(0,0,66,66);
         shape.graphics.endFill();
         _cell = new BagCell(0,info,true,shape,false);
         var _loc4_:int = 3;
         _cell.y = _loc4_;
         _cell.x = _loc4_;
         _cell.setContentSize(66,66);
         _cell.scaleX = 0.7;
         _cell.scaleY = 0.7;
         addChild(_cell);
      }
      
      private function updateGiftView(giftBagVec:Vector.<GiftRewardInfo>) : void
      {
         var i:int = 0;
         var rewardInfo:* = null;
         var name:* = null;
         var info:* = null;
         var beadInfo:* = null;
         var petInfo:* = null;
         initGiftView();
         var vec:* = giftBagVec;
         _baseTip.itemInfo.Description = "";
         for(i = 0; i <= vec.length - 1; )
         {
            rewardInfo = vec[i];
            name = "";
            info = new InventoryItemInfo();
            info.TemplateID = rewardInfo.templateId;
            info = ItemManager.fill(info);
            if(EquipType.isBead(parseInt(info.Property1)))
            {
               beadInfo = BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID);
               name = info.Name + "-" + beadInfo.Name + "Lv" + beadInfo.BaseLevel;
            }
            else if(EquipType.isMagicStone(info.CategoryID))
            {
               name = info.Name + "(" + QualityType.QUALITY_STRING[info.Quality] + ")";
            }
            else if(EquipType.isPetEgg(info.CategoryID))
            {
               petInfo = PetInfoManager.getPetByTemplateID(parseInt(info.Property5));
               name = LanguageMgr.GetTranslation("returnActivity.petTxt",petInfo.StarLevel,petInfo.Name);
            }
            else
            {
               name = info.Name;
            }
            if(_baseTip.itemInfo.Description != "")
            {
               _baseTip.itemInfo.Description = _baseTip.itemInfo.Description + "、";
            }
            _baseTip.itemInfo.Description = _baseTip.itemInfo.Description + (name + " x" + rewardInfo.count);
            i++;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_giftBagIcon);
         _giftBagIcon = null;
         ObjectUtils.disposeObject(_tipSprite);
         _tipSprite = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
      }
      
      private function addEvents() : void
      {
      }
      
      private function removeEvents() : void
      {
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}
