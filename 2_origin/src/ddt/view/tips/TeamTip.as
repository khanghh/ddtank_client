package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class TeamTip extends BaseTip implements ITip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _teamLevel:ScaleFrameImage;
      
      private var _teamName:Bitmap;
      
      private var _teamWinRate:Bitmap;
      
      private var _integraPic:Bitmap;
      
      private var _nameField:FilterFrameText;
      
      private var _winRateField:FilterFrameText;
      
      private var _integralField:FilterFrameText;
      
      private var _noTeamField:FilterFrameText;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      private var _tipInfo:Object;
      
      public function TeamTip()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         ObjectUtils.copyPropertyByRectangle(_bg,ComponentFactory.Instance.creatCustomObject("ddtteam.tips.bgRect1"));
         _teamLevel = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.teamtips.teamIcon");
         _teamLevel.setFrame(1);
         _teamName = ComponentFactory.Instance.creat("asset.teamtip.teamNameBg");
         _teamWinRate = ComponentFactory.Instance.creat("asset.teamtip.winRateBg");
         _integraPic = ComponentFactory.Instance.creat("asset.teamtip.integraBg");
         _nameField = ComponentFactory.Instance.creat("core.ReputeTxt");
         PositionUtils.setPos(_nameField,"teamTips.nameTextPos");
         _winRateField = ComponentFactory.Instance.creat("core.WinRateTxt");
         PositionUtils.setPos(_winRateField,"teamTips.winRateTextPos");
         _integralField = ComponentFactory.Instance.creat("core.BattleTxt");
         PositionUtils.setPos(_integralField,"teamTips.integralTextPos");
         _noTeamField = ComponentFactory.Instance.creat("core.WinRateTxt");
         PositionUtils.setPos(_noTeamField,"teamTips.noTeamTextPos");
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_teamLevel)
         {
            addChild(_teamLevel);
         }
         if(_teamName)
         {
            addChild(_teamName);
         }
         if(_teamWinRate)
         {
            addChild(_teamWinRate);
         }
         if(_integraPic)
         {
            addChild(_integraPic);
         }
         if(_nameField)
         {
            addChild(_nameField);
         }
         if(_nameField)
         {
            addChild(_winRateField);
         }
         if(_integralField)
         {
            addChild(_integralField);
         }
         if(_noTeamField)
         {
            addChild(_noTeamField);
         }
      }
      
      public function updateTips() : void
      {
         var nameWidth:Number = NaN;
         var rate:Number = NaN;
         _teamLevel.visible = false;
         _teamName.visible = false;
         _teamWinRate.visible = false;
         _integraPic.visible = false;
         _nameField.text = "";
         _winRateField.text = "";
         _integralField.text = "";
         _noTeamField.text = "";
         if(_tipInfo.teamName == "" && _tipInfo.teamPersonalScore == 0)
         {
            _noTeamField.text = LanguageMgr.GetTranslation("tank.team.noTeam");
            ObjectUtils.copyPropertyByRectangle(_bg,ComponentFactory.Instance.creatCustomObject("ddtteam.tips.bgRect2"));
         }
         else
         {
            ObjectUtils.copyPropertyByRectangle(_bg,ComponentFactory.Instance.creatCustomObject("ddtteam.tips.bgRect1"));
            _teamLevel.visible = true;
            _teamName.visible = true;
            _teamWinRate.visible = true;
            _integraPic.visible = true;
            _teamLevel.setFrame(_tipInfo.teamDivision + 1);
            _integralField.text = _tipInfo.teamPersonalScore;
         }
         if(_tipInfo.teamName != "" && _tipInfo.teamPersonalScore != 0)
         {
            _nameField.text = _tipInfo.teamName;
            nameWidth = _nameField.x + _nameField.width + 5;
            if(_bg.width < nameWidth)
            {
               _bg.width = nameWidth;
            }
            rate = _tipInfo.teamTotalTime > 0?_tipInfo.teamWinTime / _tipInfo.teamTotalTime * 100:0;
            _winRateField.text = rate.toFixed(2) + "%";
         }
         else if(_tipInfo.teamName == "")
         {
            _nameField.text = "";
            _winRateField.text = "";
         }
      }
      
      override public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data is PlayerInfo)
         {
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
         _tipInfo = data;
         updateTips();
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
         if(_tipWidth != w)
         {
            _tipWidth = w;
            updateTips();
         }
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(h:int) : void
      {
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_teamLevel)
         {
            ObjectUtils.disposeObject(_teamLevel);
            _teamLevel = null;
         }
         if(_teamName)
         {
            ObjectUtils.disposeObject(_teamName);
            _teamName = null;
         }
         if(_teamWinRate)
         {
            ObjectUtils.disposeObject(_teamWinRate);
            _teamWinRate = null;
         }
         if(_integraPic)
         {
            ObjectUtils.disposeObject(_integraPic);
            _integraPic = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
