package consumeRank.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consumeRank.data.ConsumeRankVo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.items.PrizeListItem;
   
   public class ConsumeRankItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _topThreeIcon:ScaleFrameImage;
      
      private var _placeTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _prizeHBox:HBox;
      
      private var index:int;
      
      private var vo:ConsumeRankVo;
      
      public function ConsumeRankItem(param1:int)
      {
         super();
         this.index = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:* = index % 2;
         if(0 !== _loc1_)
         {
            if(1 === _loc1_)
            {
               _bg = ComponentFactory.Instance.creat("wonderfulactivity.itemBg1");
            }
         }
         else
         {
            _bg = ComponentFactory.Instance.creat("wonderfulactivity.itemBg0");
         }
         addChild(_bg);
         _topThreeIcon = ComponentFactory.Instance.creatComponentByStylename("wonderful.consumeRank.topThree");
         addChild(_topThreeIcon);
         _topThreeIcon.visible = false;
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.consumeRank.placeTxt");
         _placeTxt.text = "4th";
         addChild(_placeTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.consumeRank.nameTxt");
         _nameTxt.text = "小妹也带刀";
         addChild(_nameTxt);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("wonderful.consumeRank.numTxt");
         _numTxt.text = "10000";
         addChild(_numTxt);
         _prizeHBox = ComponentFactory.Instance.creatComponentByStylename("wonderful.consumeRank.hbox");
         addChild(_prizeHBox);
      }
      
      public function setData(param1:ConsumeRankVo, param2:GiftBagInfo) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         this.vo = param1;
         setRankNum(index + 1);
         addNickName();
         _numTxt.text = param1.consume.toString();
         if(!param2)
         {
            return;
         }
         var _loc3_:Vector.<GiftRewardInfo> = param2.giftRewardArr;
         _loc6_ = 0;
         while(_loc6_ <= _loc3_.length - 1)
         {
            _loc5_ = _loc3_[_loc6_];
            _loc4_ = new PrizeListItem();
            _loc4_.initView(_loc6_);
            _loc4_.setCellData(_loc5_);
            _prizeHBox.addChild(_loc4_);
            _loc6_++;
         }
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
      
      private function addNickName() : void
      {
         var _loc1_:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !vo.isVIP;
         if(vo.isVIP)
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
