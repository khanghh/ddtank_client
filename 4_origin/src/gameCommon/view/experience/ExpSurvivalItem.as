package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import gameCommon.model.Player;
   import vip.VipController;
   
   public class ExpSurvivalItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _rankImage:ScaleFrameImage;
      
      private var _rankText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nickName:FilterFrameText;
      
      private var _killNum:FilterFrameText;
      
      private var _flopNum:FilterFrameText;
      
      private var _luckyBitmap:Bitmap;
      
      private var _twoflops:Bitmap;
      
      public function ExpSurvivalItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.core.survival.item.selfBg");
         addChild(_bg);
         _rankImage = ComponentFactory.Instance.creatComponentByStylename("survival.topThreeRank");
         addChild(_rankImage);
         _rankText = ComponentFactory.Instance.creatComponentByStylename("gameOver.survival.rankTxt");
         addChild(_rankText);
         _nickName = ComponentFactory.Instance.creatComponentByStylename("gameOver.survival.nickNameTxt");
         addChild(_nickName);
         _killNum = ComponentFactory.Instance.creatComponentByStylename("gameOver.survival.killNumTxt");
         addChild(_killNum);
         _flopNum = ComponentFactory.Instance.creatComponentByStylename("gameOver.survival.flopNumTxt");
         addChild(_flopNum);
         _luckyBitmap = ComponentFactory.Instance.creat("asset.core.survival.lucky");
         addChild(_luckyBitmap);
         _twoflops = ComponentFactory.Instance.creat("asset.core.survival.twoFlops");
         addChild(_twoflops);
      }
      
      public function setItemInfo(param1:int, param2:Player) : void
      {
         var _loc3_:* = null;
         if(param1 <= 3)
         {
            _rankImage.setFrame(param1);
            _rankText.visible = false;
         }
         else
         {
            _rankImage.visible = false;
            _rankText.text = param1.toString() + "th";
         }
         if(param2.playerInfo.IsVIP)
         {
            _nickName.visible = false;
            if(_vipName)
            {
               ObjectUtils.disposeObject(_vipName);
            }
            _vipName = VipController.instance.getVipNameTxt(110,param2.playerInfo.typeVIP);
            _loc3_ = new TextFormat();
            _loc3_.align = "left";
            _loc3_.bold = true;
            _vipName.textField.defaultTextFormat = _loc3_;
            _vipName.textSize = 16;
            _vipName.x = _nickName.x;
            _vipName.y = _nickName.y;
            _vipName.text = param2.playerInfo.NickName;
            addChild(_vipName);
         }
         else
         {
            _nickName.text = param2.playerInfo.NickName;
         }
         _killNum.text = param2.killNum.toString();
         _flopNum.text = param2.expObj.canTakeOut;
         var _loc4_:* = param2.isWin;
         _twoflops.visible = _loc4_;
         _luckyBitmap.visible = _loc4_;
         addChild(_luckyBitmap);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
