package RechargeRank.views
{
   import RechargeRank.data.RechargeRankVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.items.PrizeListItem;
   
   public class RechargeRankItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _topThreeIcon:ScaleFrameImage;
      
      private var _placeTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _prizeHBox:HBox;
      
      private var index:int;
      
      private var vo:RechargeRankVo;
      
      public function RechargeRankItem(index:int)
      {
         super();
         this.index = index;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:* = index % 2;
         if(0 !== _loc1_)
         {
            if(1 === _loc1_)
            {
               _bg = ComponentFactory.Instance.creat("wonderfulactivity.rechargeRank.itemBg1");
            }
         }
         else
         {
            _bg = ComponentFactory.Instance.creat("wonderfulactivity.rechargeRank.itemBg0");
         }
         addChild(_bg);
         _topThreeIcon = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.topThree");
         addChild(_topThreeIcon);
         _topThreeIcon.visible = false;
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.placeTxt");
         _placeTxt.text = "4th";
         addChild(_placeTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.nameTxt");
         _nameTxt.text = "小妹也带刀";
         addChild(_nameTxt);
         _prizeHBox = ComponentFactory.Instance.creatComponentByStylename("wonderful.rechargeRank.hbox");
         addChild(_prizeHBox);
      }
      
      public function setData(vo:RechargeRankVo, giftInfo:GiftBagInfo) : void
      {
         var i:int = 0;
         var gift:* = null;
         var prizeItem:* = null;
         this.vo = vo;
         setRankNum(index + 1);
         addNickName();
         if(!giftInfo)
         {
            return;
         }
         var rewardArr:Vector.<GiftRewardInfo> = giftInfo.giftRewardArr;
         for(i = 0; i <= rewardArr.length - 1; )
         {
            gift = rewardArr[i];
            prizeItem = new PrizeListItem();
            prizeItem.initView(i);
            prizeItem.setCellData(gift);
            _prizeHBox.addChild(prizeItem);
            i++;
         }
      }
      
      private function setRankNum(num:int) : void
      {
         if(num <= 3)
         {
            _placeTxt.visible = false;
            _topThreeIcon.visible = true;
            _topThreeIcon.setFrame(num);
         }
         else
         {
            _placeTxt.visible = true;
            _topThreeIcon.visible = false;
            _placeTxt.text = num + "th";
         }
      }
      
      private function addNickName() : void
      {
         var textFormat:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !vo.isVIP;
         if(vo.isVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            textFormat = new TextFormat();
            textFormat.align = "center";
            textFormat.bold = true;
            _vipName.textField.defaultTextFormat = textFormat;
            _vipName.textSize = 16;
            _vipName.textField.width = _nameTxt.width;
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = vo.name;
            addChild(_vipName);
         }
         else
         {
            _nameTxt.text = vo.name;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
      }
   }
}
