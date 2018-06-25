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
      
      public function set info(info:DDTMatchQuestionInfo) : void
      {
         _info = info;
         setRankNum(_info.Rank);
         addNickName();
         _scoreTxt.text = _info.Integer.toString();
         if(_info.AwardInfoVec)
         {
            _award.info = _info.AwardInfoVec;
         }
      }
      
      private function setRankNum(num:int) : void
      {
         _index = num;
         if(num <= 3)
         {
            _topThreeRank.visible = true;
            _topThreeRank.setFrame(num);
            _rankTxt.visible = false;
         }
         else
         {
            _rankTxt.text = num.toString() + "th";
            _topThreeRank.visible = false;
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
         _nameTxt.visible = !_info.IsVIP;
         if(_info.IsVIP)
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
      var award:* = null;
      var i:int = 0;
      _awardVec = new Vector.<BagCell>();
      for(i = 0; i < AWARD_NUM; )
      {
         award = new BagCell(i,null,true,null,false);
         award.BGVisible = false;
         award.setContentSize(28,28);
         award.x = i * 35;
         award.y = 3;
         addChild(award);
         _awardVec.push(award);
         i++;
      }
   }
   
   public function set info(infoVec:Vector.<AwardInfo>) : void
   {
      var i:int = 0;
      var item:* = null;
      for(i = 0; i < infoVec.length; )
      {
         item = new InventoryItemInfo();
         item.TemplateID = infoVec[i].TempId;
         item.IsBinds = infoVec[i].IsBind;
         item.ValidDate = infoVec[i].ValidDate;
         _awardVec[i].info = ItemManager.fill(item);
         _awardVec[i].setCount(infoVec[i].AwardNum);
         i++;
      }
   }
   
   public function dispose() : void
   {
      var i:int = 0;
      if(_awardVec)
      {
         for(i = 0; i < AWARD_NUM; )
         {
            _awardVec[i].dispose();
            _awardVec[i] = null;
            i++;
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
