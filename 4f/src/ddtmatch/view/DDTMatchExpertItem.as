package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddtmatch.data.DDTMatchQuestionInfo;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class DDTMatchExpertItem extends Sprite implements Disposeable
   {
       
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _topThreeRank:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _award:ItemAward;
      
      private var _info:DDTMatchQuestionInfo;
      
      public function DDTMatchExpertItem(){super();}
      
      private function init() : void{}
      
      public function set info(param1:DDTMatchQuestionInfo) : void{}
      
      private function setRankNum(param1:int) : void{}
      
      private function addNickName() : void{}
      
      public function dispose() : void{}
   }
}

import bagAndInfo.cell.BagCell;
import ddt.data.goods.InventoryItemInfo;
import ddt.manager.ItemManager;
import ddtmatch.data.AwardInfo;
import flash.display.Sprite;

class ItemAward extends Sprite
{
   
   private static var AWARD_NUM:int = 3;
    
   
   private var _awardVec:Vector.<BagCell>;
   
   function ItemAward(){super();}
   
   private function initView() : void{}
   
   public function set info(param1:Vector.<AwardInfo>) : void{}
   
   public function dispose() : void{}
}
