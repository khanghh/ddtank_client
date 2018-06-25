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
      
      private function checkBtnHandler(event:MouseEvent) : void
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
         var i:int = 0;
         var rankInfo:* = null;
         var hbox:* = null;
         var j:int = 0;
         var info:* = null;
         var attrArr:* = null;
         var cell:* = null;
         var countTxt:* = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         vbox = ComponentFactory.Instance.creatComponentByStylename("rank.ActivityState.Vbox");
         addChild(vbox);
         for(i = 1; i <= RankManager.instance.model.currentInfo.giftbagArray.length; )
         {
            rankInfo = new RankInfo();
            rankInfo = RankManager.instance.rankData(RankManager.instance.model.currentInfo.giftbagArray,i);
            if(rankInfo && rankInfo.giftRewardArr)
            {
               hbox = new HBox();
               for(j = 0; j < rankInfo.giftRewardArr.length; )
               {
                  info = new InventoryItemInfo();
                  info.TemplateID = rankInfo.giftRewardArr[j].templateId;
                  info = ItemManager.fill(info);
                  info.IsBinds = rankInfo.giftRewardArr[j].isBind;
                  info.ValidDate = rankInfo.giftRewardArr[j].validDate;
                  attrArr = rankInfo.giftRewardArr[j].property.split(",");
                  info.StrengthenLevel = parseInt(attrArr[0]);
                  info.AttackCompose = parseInt(attrArr[1]);
                  info.DefendCompose = parseInt(attrArr[2]);
                  info.AgilityCompose = parseInt(attrArr[3]);
                  info.LuckCompose = parseInt(attrArr[4]);
                  if(EquipType.isMagicStone(info.CategoryID))
                  {
                     info.Level = info.StrengthenLevel;
                     info.Attack = info.AttackCompose;
                     info.Defence = info.DefendCompose;
                     info.Agility = info.AgilityCompose;
                     info.Luck = info.LuckCompose;
                     info.MagicAttack = parseInt(attrArr[6]);
                     info.MagicDefence = parseInt(attrArr[7]);
                     info.StrengthenExp = parseInt(attrArr[8]);
                  }
                  info.Count = rankInfo.giftRewardArr[j].count;
                  cell = new BagCell(0,info,false,ComponentFactory.Instance.creatBitmap("asset.rank.cellBg"));
                  if(info.MaxCount == 1 && info.Count > info.MaxCount)
                  {
                     countTxt = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
                     countTxt.text = String(info.Count);
                     countTxt.x = 34;
                     countTxt.y = 31;
                     cell.addChild(countTxt);
                  }
                  cell.x = j * cell.width;
                  cell.refreshTbxPos();
                  hbox.addChild(cell);
                  j++;
               }
               hbox.y = i * 50;
               vbox.addChild(hbox);
            }
            i++;
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
