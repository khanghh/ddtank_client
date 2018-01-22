package consortion.view.boss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class BossMemberItem extends Sprite implements Disposeable
   {
       
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankIconList:Vector.<Bitmap>;
      
      private var _nameTxt:FilterFrameText;
      
      private var _nameFirstTxt:GradientText;
      
      private var _damageTxt:FilterFrameText;
      
      private var _contributionTxt:FilterFrameText;
      
      private var _honorTxt:FilterFrameText;
      
      public function BossMemberItem()
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         super();
         _rankIconList = new Vector.<Bitmap>(3);
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.cellRankth" + (_loc3_ + 1));
            addChild(_loc1_);
            _rankIconList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.rankTxt");
         addChild(_rankTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.nameTxt");
         addChild(_nameTxt);
         _nameFirstTxt = VipController.instance.getVipNameTxt(105,1);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.align = "center";
         _loc2_.bold = true;
         _nameFirstTxt.textField.defaultTextFormat = _loc2_;
         _nameFirstTxt.textSize = 14;
         _nameFirstTxt.x = _nameTxt.x + 2;
         _nameFirstTxt.y = _nameTxt.y;
         addChild(_nameFirstTxt);
         _damageTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.damageTxt");
         addChild(_damageTxt);
         _contributionTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.contributionTxt");
         addChild(_contributionTxt);
         _honorTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.honorTxt");
         addChild(_honorTxt);
      }
      
      public function set info(param1:ConsortiaBossDataVo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = param1.rank;
         setRankIconVisible(_loc2_);
         if(_loc2_ >= 1 && _loc2_ <= 3)
         {
            _rankTxt.visible = false;
         }
         else
         {
            _rankTxt.text = _loc2_ + "th";
            _rankTxt.visible = true;
         }
         if(_loc2_ == 1)
         {
            _nameTxt.visible = false;
            _nameFirstTxt.text = param1.name;
            _nameFirstTxt.visible = true;
         }
         else
         {
            _nameFirstTxt.visible = false;
            _nameTxt.text = param1.name;
            _nameTxt.visible = true;
         }
         _damageTxt.text = param1.damage.toString();
         _contributionTxt.text = param1.contribution.toString();
         _honorTxt.text = param1.honor.toString();
      }
      
      private function setRankIconVisible(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _rankIconList.length;
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            if(param1 == _loc3_)
            {
               _rankIconList[_loc3_ - 1].visible = true;
            }
            else
            {
               _rankIconList[_loc3_ - 1].visible = false;
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _rankTxt = null;
         _rankIconList = null;
         _nameTxt = null;
         _nameFirstTxt = null;
         _damageTxt = null;
         _contributionTxt = null;
         _honorTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
