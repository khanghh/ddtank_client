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
      
      public function RechargeRankItem(param1:int){super();}
      
      private function initView() : void{}
      
      public function setData(param1:RechargeRankVo, param2:GiftBagInfo) : void{}
      
      private function setRankNum(param1:int) : void{}
      
      private function addNickName() : void{}
      
      public function dispose() : void{}
   }
}
