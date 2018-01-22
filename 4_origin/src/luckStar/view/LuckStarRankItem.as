package luckStar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import luckStar.model.LuckStarPlayerInfo;
   
   public class LuckStarRankItem extends Sprite implements Disposeable
   {
       
      
      private var _vipName:GradientText;
      
      private var _rankName:FilterFrameText;
      
      private var _rankText:FilterFrameText;
      
      private var _rankScore:FilterFrameText;
      
      private var _rankIcon:ScaleFrameImage;
      
      private var _info:LuckStarPlayerInfo;
      
      public function LuckStarRankItem()
      {
         super();
         _rankIcon = ComponentFactory.Instance.creat("luckyStar.rankItem.topThreeRink");
         _rankText = ComponentFactory.Instance.creat("luckyStar.rankItem.rankText");
         _rankScore = ComponentFactory.Instance.creat("luckyStar.rankItem.rankScore");
         _vipName = ComponentFactory.Instance.creat("luckyStar.rankItem.gradueteNumText");
         _rankName = ComponentFactory.Instance.creat("luckyStar.rankItem.rankNmaeText");
         addChild(_rankIcon);
         addChild(_rankText);
         addChild(_rankScore);
         addChild(_vipName);
         addChild(_rankName);
         resetItem();
      }
      
      public function set info(param1:LuckStarPlayerInfo) : void
      {
         _info = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         updateRank();
         updateName();
         updateScore();
      }
      
      public function resetItem() : void
      {
         _rankIcon.visible = false;
         _rankText.visible = false;
         _rankName.visible = false;
         _vipName.visible = false;
         _rankScore.text = "";
      }
      
      private function updateRank() : void
      {
         _rankIcon.visible = false;
         _rankText.visible = false;
         if(_info.rank < 4)
         {
            _rankIcon.visible = true;
            _rankIcon.setFrame(_info.rank);
            return;
         }
         _rankText.visible = true;
         _rankText.text = _info.rank + "th";
      }
      
      private function updateName() : void
      {
         var _loc2_:int = 133;
         var _loc1_:int = 60;
         _rankName.visible = false;
         _vipName.visible = false;
         if(_info.isVip)
         {
            _vipName.visible = true;
            _vipName.text = _info.name;
            if(_vipName.width < _loc2_)
            {
               _vipName.x = _loc1_ + (_loc2_ - _vipName.width) / 2;
            }
            else if(_vipName.width > _loc2_)
            {
               _vipName.width = _loc2_;
               _vipName.x = _loc1_;
            }
            return;
         }
         _rankName.visible = true;
         _rankName.text = _info.name;
      }
      
      private function updateScore() : void
      {
         _rankScore.text = _info.starNum.toString();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankIcon);
         _rankIcon = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_rankScore);
         _rankScore = null;
         ObjectUtils.disposeObject(_rankName);
         _rankName = null;
         _info = null;
      }
   }
}
