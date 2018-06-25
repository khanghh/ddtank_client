package lanternriddles.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import lanternriddles.data.LanternInfo;
   import vip.VipController;
   
   public class LanternRankItem extends Sprite
   {
       
      
      private var _id:int;
      
      private var _topThreeRank:ScaleFrameImage;
      
      private var _rankNum:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nickName:FilterFrameText;
      
      private var _integral:FilterFrameText;
      
      private var _award:LanternRankItemAward;
      
      private var _info:LanternInfo;
      
      public function LanternRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _topThreeRank = ComponentFactory.Instance.creat("lantern.view.topThreeRank");
         addChild(_topThreeRank);
         _topThreeRank.visible = false;
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("lantern.view.rankNum");
         addChild(_rankNum);
         _nickName = ComponentFactory.Instance.creatComponentByStylename("lantern.view.nickName");
         addChild(_nickName);
         _integral = ComponentFactory.Instance.creatComponentByStylename("lantern.view.integral");
         addChild(_integral);
         _award = new LanternRankItemAward();
         PositionUtils.setPos(_award,"lantern.view.rankAwardPos");
         addChild(_award);
      }
      
      public function set info(info:LanternInfo) : void
      {
         _info = info;
         setRankNum(_info.Rank);
         addNickName();
         _integral.text = _info.Integer.toString();
         if(_info.AwardInfoVec)
         {
            _award.info = _info.AwardInfoVec;
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
         _nickName.visible = !_info.IsVIP;
         if(_info.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            textFormat = new TextFormat();
            textFormat.align = "center";
            textFormat.bold = true;
            _vipName.textField.defaultTextFormat = textFormat;
            _vipName.textSize = 16;
            _vipName.textField.width = _nickName.width;
            _vipName.x = _nickName.x;
            _vipName.y = _nickName.y;
            _vipName.text = _info.NickName;
            addChild(_vipName);
         }
         else
         {
            _nickName.text = _info.NickName;
         }
      }
      
      private function setRankNum(num:int) : void
      {
         _id = num;
         if(num <= 3)
         {
            _topThreeRank.visible = true;
            _topThreeRank.setFrame(num);
            _rankNum.visible = false;
         }
         else
         {
            _rankNum.text = num.toString() + "th";
            _topThreeRank.visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(_rankNum)
         {
            _rankNum.dispose();
            _rankNum = null;
         }
         if(_topThreeRank)
         {
            _topThreeRank.dispose();
            _topThreeRank = null;
         }
         if(_nickName)
         {
            _nickName.dispose();
            _nickName = null;
         }
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         if(_integral)
         {
            _integral.dispose();
            _integral = null;
         }
         if(_award)
         {
            _award.dispose();
            _award = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
