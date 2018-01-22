package rank.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rank.RankManager;
   import rank.data.RankInfo;
   
   public class RankRewardView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var vbox:VBox;
      
      private var _checkBtn:BaseButton;
      
      private var type:int;
      
      private var _frame:RankInfoFrame;
      
      public function RankRewardView()
      {
         super();
         createUI();
      }
      
      private function createUI() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.rank.reward.bg");
         addChild(_bg);
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("rank.checkRankBtn");
         addChild(_checkBtn);
         _checkBtn.addEventListener("click",checkBtnHandler);
      }
      
      private function checkBtnHandler(param1:MouseEvent) : void
      {
         if(RankManager.instance.reweadDataList && RankManager.instance.reweadDataList.length > 0)
         {
            _frame = ComponentFactory.Instance.creatCustomObject("rank.RankInfoFrame");
            _frame.titleText = LanguageMgr.GetTranslation("ddt.rankFrame.title");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      public function setData() : void
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         vbox = ComponentFactory.Instance.creatComponentByStylename("rank.ActivityState.Vbox");
         addChild(vbox);
         _loc8_ = 1;
         while(_loc8_ <= RankManager.instance.model.currentInfo.giftbagArray.length)
         {
            _loc6_ = new RankInfo();
            _loc6_ = RankManager.instance.rankData(RankManager.instance.model.currentInfo.giftbagArray,_loc8_);
            if(_loc6_ && _loc6_.giftRewardArr)
            {
               _loc1_ = new HBox();
               _loc5_ = 0;
               while(_loc5_ < _loc6_.giftRewardArr.length)
               {
                  _loc7_ = new InventoryItemInfo();
                  _loc7_.TemplateID = _loc6_.giftRewardArr[_loc5_].templateId;
                  _loc7_ = ItemManager.fill(_loc7_);
                  _loc7_.IsBinds = _loc6_.giftRewardArr[_loc5_].isBind;
                  _loc7_.ValidDate = _loc6_.giftRewardArr[_loc5_].validDate;
                  _loc4_ = _loc6_.giftRewardArr[_loc5_].property.split(",");
                  _loc7_.StrengthenLevel = parseInt(_loc4_[0]);
                  _loc7_.AttackCompose = parseInt(_loc4_[1]);
                  _loc7_.DefendCompose = parseInt(_loc4_[2]);
                  _loc7_.AgilityCompose = parseInt(_loc4_[3]);
                  _loc7_.LuckCompose = parseInt(_loc4_[4]);
                  if(EquipType.isMagicStone(_loc7_.CategoryID))
                  {
                     _loc7_.Level = _loc7_.StrengthenLevel;
                     _loc7_.Attack = _loc7_.AttackCompose;
                     _loc7_.Defence = _loc7_.DefendCompose;
                     _loc7_.Agility = _loc7_.AgilityCompose;
                     _loc7_.Luck = _loc7_.LuckCompose;
                     _loc7_.MagicAttack = parseInt(_loc4_[6]);
                     _loc7_.MagicDefence = parseInt(_loc4_[7]);
                     _loc7_.StrengthenExp = parseInt(_loc4_[8]);
                  }
                  _loc7_.Count = _loc6_.giftRewardArr[_loc5_].count;
                  _loc2_ = new BagCell(0,_loc7_,false,ComponentFactory.Instance.creatBitmap("asset.rank.cellBg"));
                  if(_loc7_.MaxCount == 1 && _loc7_.Count > _loc7_.MaxCount)
                  {
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
                     _loc3_.text = String(_loc7_.Count);
                     _loc3_.x = 34;
                     _loc3_.y = 31;
                     _loc2_.addChild(_loc3_);
                  }
                  _loc2_.x = _loc5_ * _loc2_.width;
                  _loc2_.refreshTbxPos();
                  _loc1_.addChild(_loc2_);
                  _loc5_++;
               }
               _loc1_.y = _loc8_ * 50;
               vbox.addChild(_loc1_);
            }
            _loc8_++;
         }
      }
      
      public function dispose() : void
      {
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("click",checkBtnHandler);
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
