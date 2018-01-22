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
      
      public function GiftBagItem(param1:int, param2:int)
      {
         super();
         _type = param1;
         _index = param2 == 0?1:param2;
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
         var _loc1_:ItemTemplateInfo = new ItemTemplateInfo();
         _loc1_.Quality = 4;
         _loc1_.CategoryID = 11;
         _loc1_.Name = _type == 0?LanguageMgr.GetTranslation("returnActivity.rechargeGiftName"):LanguageMgr.GetTranslation("returnActivity.consumeGiftName");
         _baseTip.itemInfo = _loc1_;
         _tipSprite.width = _giftBagIcon.width;
         _tipSprite.height = _giftBagIcon.height;
         _tipSprite.tipStyle = "core.GoodsTip";
         _tipSprite.tipDirctions = "7";
         _tipSprite.tipData = _baseTip;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1)
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
      
      public function setData(param1:Vector.<GiftRewardInfo>) : void
      {
         updateGiftView(param1);
      }
      
      private function updateGoodsView(param1:GiftRewardInfo) : void
      {
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = param1.templateId;
         _loc3_ = ItemManager.fill(_loc3_);
         _loc3_.ValidDate = param1.validDate;
         _loc3_.Count = param1.count;
         _loc3_.IsBinds = param1.isBind;
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,66,66);
         _loc2_.graphics.endFill();
         _cell = new BagCell(0,_loc3_,true,_loc2_,false);
         var _loc4_:int = 3;
         _cell.y = _loc4_;
         _cell.x = _loc4_;
         _cell.setContentSize(66,66);
         _cell.scaleX = 0.7;
         _cell.scaleY = 0.7;
         addChild(_cell);
      }
      
      private function updateGiftView(param1:Vector.<GiftRewardInfo>) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         initGiftView();
         var _loc8_:* = param1;
         _baseTip.itemInfo.Description = "";
         _loc7_ = 0;
         while(_loc7_ <= _loc8_.length - 1)
         {
            _loc2_ = _loc8_[_loc7_];
            _loc3_ = "";
            _loc6_ = new InventoryItemInfo();
            _loc6_.TemplateID = _loc2_.templateId;
            _loc6_ = ItemManager.fill(_loc6_);
            if(EquipType.isBead(parseInt(_loc6_.Property1)))
            {
               _loc4_ = BeadTemplateManager.Instance.GetBeadInfobyID(_loc6_.TemplateID);
               _loc3_ = _loc6_.Name + "-" + _loc4_.Name + "Lv" + _loc4_.BaseLevel;
            }
            else if(EquipType.isMagicStone(_loc6_.CategoryID))
            {
               _loc3_ = _loc6_.Name + "(" + QualityType.QUALITY_STRING[_loc6_.Quality] + ")";
            }
            else if(EquipType.isPetEgg(_loc6_.CategoryID))
            {
               _loc5_ = PetInfoManager.getPetByTemplateID(parseInt(_loc6_.Property5));
               _loc3_ = LanguageMgr.GetTranslation("returnActivity.petTxt",_loc5_.StarLevel,_loc5_.Name);
            }
            else
            {
               _loc3_ = _loc6_.Name;
            }
            if(_baseTip.itemInfo.Description != "")
            {
               _baseTip.itemInfo.Description = _baseTip.itemInfo.Description + "、";
            }
            _baseTip.itemInfo.Description = _baseTip.itemInfo.Description + (_loc3_ + " x" + _loc2_.count);
            _loc7_++;
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
