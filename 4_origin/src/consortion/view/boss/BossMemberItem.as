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
         var i:int = 0;
         var rankIcon:* = null;
         super();
         _rankIconList = new Vector.<Bitmap>(3);
         for(i = 0; i < 3; )
         {
            rankIcon = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.cellRankth" + (i + 1));
            addChild(rankIcon);
            _rankIconList[i] = rankIcon;
            i++;
         }
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.rankTxt");
         addChild(_rankTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.cell.nameTxt");
         addChild(_nameTxt);
         _nameFirstTxt = VipController.instance.getVipNameTxt(105,1);
         var textFormat:TextFormat = new TextFormat();
         textFormat.align = "center";
         textFormat.bold = true;
         _nameFirstTxt.textField.defaultTextFormat = textFormat;
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
      
      public function set info(info:ConsortiaBossDataVo) : void
      {
         if(!info)
         {
            return;
         }
         var rank:int = info.rank;
         setRankIconVisible(rank);
         if(rank >= 1 && rank <= 3)
         {
            _rankTxt.visible = false;
         }
         else
         {
            _rankTxt.text = rank + "th";
            _rankTxt.visible = true;
         }
         if(rank == 1)
         {
            _nameTxt.visible = false;
            _nameFirstTxt.text = info.name;
            _nameFirstTxt.visible = true;
         }
         else
         {
            _nameFirstTxt.visible = false;
            _nameTxt.text = info.name;
            _nameTxt.visible = true;
         }
         _damageTxt.text = info.damage.toString();
         _contributionTxt.text = info.contribution.toString();
         _honorTxt.text = info.honor.toString();
      }
      
      private function setRankIconVisible(rank:int) : void
      {
         var i:int = 0;
         var len:int = _rankIconList.length;
         for(i = 1; i <= len; )
         {
            if(rank == i)
            {
               _rankIconList[i - 1].visible = true;
            }
            else
            {
               _rankIconList[i - 1].visible = false;
            }
            i++;
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
