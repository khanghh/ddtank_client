package demonChiYou.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouModel;
   import flash.display.Sprite;
   
   public class RewardResultItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _data:Object;
      
      private var _mgr:DemonChiYouManager;
      
      private var _model:DemonChiYouModel;
      
      private var _rewardResultItemGoodNameTf:FilterFrameText;
      
      private var _rewardResultItemOwnerNameTf:FilterFrameText;
      
      private var _rewardResultItemTopPointTf:FilterFrameText;
      
      private var _rewardResultItemMyPointTf:FilterFrameText;
      
      private var _rewardResultItemCongratulateTf:FilterFrameText;
      
      private var _rewardResultItemHasBuy:Image;
      
      public function RewardResultItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:* = null;
         _mgr = DemonChiYouManager.instance;
         _model = _mgr.model;
         _data = _model.shopInfoArr[_index];
         var _loc2_:InventoryItemInfo = _data["InventoryItemInfo"];
         _rewardResultItemGoodNameTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardResultItemGoodNameTf",_loc2_.Name + "*" + _loc2_.Count,this);
         if(_data["HasRoll"])
         {
            _rewardResultItemOwnerNameTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardResultItemOwnerNameTf","",this);
            _rewardResultItemOwnerNameTf.htmlText = LanguageMgr.GetTranslation("demonChiYou.rewardResultItemOwnerName",_data["NickName"]);
         }
         var _loc3_:int = _data["TopPoint"] == -1?0:_data["TopPoint"];
         _rewardResultItemTopPointTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardResultItemTopPointTf",LanguageMgr.GetTranslation("demonChiYou.rewardResultItemTopPoint",_loc3_),this);
         var _loc4_:int = _data["MyPoint"] == -1?0:_data["MyPoint"];
         _rewardResultItemMyPointTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardResultItemMyPointTf",LanguageMgr.GetTranslation("demonChiYou.rewardResultItemMyPoint",_loc4_),this);
         if(_loc4_ > 0)
         {
            if(_data["PlayerId"] != PlayerManager.Instance.Self.ID)
            {
               _loc1_ = ItemManager.Instance.getTemplateById(11903).Name + "*" + _data["MyRollCount"];
               _rewardResultItemCongratulateTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardResultItemCongratulateTf",LanguageMgr.GetTranslation("demonChiYou.rewardResultItemCongratulate",_loc1_),this);
            }
         }
         if(_data["HasBuy"])
         {
            _rewardResultItemHasBuy = UICreatShortcut.creatAndAdd("demonChiYou.rewardResultItemHasBuy",this);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _mgr = null;
         _model = null;
         _rewardResultItemGoodNameTf = null;
         _rewardResultItemOwnerNameTf = null;
         _rewardResultItemTopPointTf = null;
         _rewardResultItemMyPointTf = null;
         _rewardResultItemCongratulateTf = null;
         _rewardResultItemHasBuy = null;
      }
   }
}
