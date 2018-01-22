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
      
      public function DDTMatchExpertItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _topThreeRank = ComponentFactory.Instance.creat("ddtmatch.expert.topThreeRink");
         addChild(_topThreeRank);
         _topThreeRank.visible = false;
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.rankItemTxt");
         addChild(_rankTxt);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.scoreItemTxt");
         addChild(_scoreTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.expert.nameItemTxt");
         addChild(_nameTxt);
         _award = new ItemAward();
         PositionUtils.setPos(_award,"ddtmatch.expert.cellPos");
         addChild(_award);
      }
      
      public function set info(param1:DDTMatchQuestionInfo) : void
      {
         _info = param1;
         setRankNum(_info.Rank);
         addNickName();
         _scoreTxt.text = _info.Integer.toString();
         if(_info.AwardInfoVec)
         {
            _award.info = _info.AwardInfoVec;
         }
      }
      
      private function setRankNum(param1:int) : void
      {
         _index = param1;
         if(param1 <= 3)
         {
            _topThreeRank.visible = true;
            _topThreeRank.setFrame(param1);
            _rankTxt.visible = false;
         }
         else
         {
            _rankTxt.text = param1.toString() + "th";
            _topThreeRank.visible = false;
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
         _nameTxt.visible = !_info.IsVIP;
         if(_info.IsVIP)
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
            _vipName.text = _info.NickName;
            addChild(_vipName);
         }
         else
         {
            _nameTxt.text = _info.NickName;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_topThreeRank);
         _topThreeRank = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_award);
         _award = null;
      }
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
   
   function ItemAward()
   {
      super();
      initView();
   }
   
   private function initView() : void
   {
      var _loc1_:* = null;
      var _loc2_:int = 0;
      _awardVec = new Vector.<BagCell>();
      _loc2_ = 0;
      while(_loc2_ < AWARD_NUM)
      {
         _loc1_ = new BagCell(_loc2_,null,true,null,false);
         _loc1_.BGVisible = false;
         _loc1_.setContentSize(28,28);
         _loc1_.x = _loc2_ * 35;
         _loc1_.y = 3;
         addChild(_loc1_);
         _awardVec.push(_loc1_);
         _loc2_++;
      }
   }
   
   public function set info(param1:Vector.<AwardInfo>) : void
   {
      var _loc3_:int = 0;
      var _loc2_:* = null;
      _loc3_ = 0;
      while(_loc3_ < param1.length)
      {
         _loc2_ = new InventoryItemInfo();
         _loc2_.TemplateID = param1[_loc3_].TempId;
         _loc2_.IsBinds = param1[_loc3_].IsBind;
         _loc2_.ValidDate = param1[_loc3_].ValidDate;
         _awardVec[_loc3_].info = ItemManager.fill(_loc2_);
         _awardVec[_loc3_].setCount(param1[_loc3_].AwardNum);
         _loc3_++;
      }
   }
   
   public function dispose() : void
   {
      var _loc1_:int = 0;
      if(_awardVec)
      {
         _loc1_ = 0;
         while(_loc1_ < AWARD_NUM)
         {
            _awardVec[_loc1_].dispose();
            _awardVec[_loc1_] = null;
            _loc1_++;
         }
         _awardVec.length = 0;
         _awardVec = null;
      }
      if(this.parent)
      {
         this.parent.removeChild(this);
      }
   }
}
