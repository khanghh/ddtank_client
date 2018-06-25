package pvePowerBuff
{
   import baglocked.BaglockedManager;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.utils.StaticFormula;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PvePowerBuffMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _otherForeAtk:FilterFrameText;
      
      private var _otherForeDef:FilterFrameText;
      
      private var _otherForeAgl:FilterFrameText;
      
      private var _otherForeLuck:FilterFrameText;
      
      private var _otherForeHp:FilterFrameText;
      
      private var _otherForeMAtk:FilterFrameText;
      
      private var _otherForeMDef:FilterFrameText;
      
      private var _otherForeDmg:FilterFrameText;
      
      private var _otherForeAr:FilterFrameText;
      
      private var _otherRearAtk:FilterFrameText;
      
      private var _otherRearDef:FilterFrameText;
      
      private var _otherRearAgl:FilterFrameText;
      
      private var _otherRearLuck:FilterFrameText;
      
      private var _otherRearHp:FilterFrameText;
      
      private var _otherRearMAtk:FilterFrameText;
      
      private var _otherRearMDef:FilterFrameText;
      
      private var _otherRearDmg:FilterFrameText;
      
      private var _otherRearAr:FilterFrameText;
      
      private var _atkIconBm:Bitmap;
      
      private var _defIconBm:Bitmap;
      
      private var _aglIconBm:Bitmap;
      
      private var _luckIconBm:Bitmap;
      
      private var _hpIconBm:Bitmap;
      
      private var _matkIconBm:Bitmap;
      
      private var _mdefIconBm:Bitmap;
      
      private var _dmgIconBm:Bitmap;
      
      private var _arIconBm:Bitmap;
      
      private var _selfForeAtk:FilterFrameText;
      
      private var _selfForeDef:FilterFrameText;
      
      private var _selfForeAgl:FilterFrameText;
      
      private var _selfForeLuck:FilterFrameText;
      
      private var _selfForeHp:FilterFrameText;
      
      private var _selfForeMAtk:FilterFrameText;
      
      private var _selfForeMDef:FilterFrameText;
      
      private var _selfForeDmg:FilterFrameText;
      
      private var _selfForeAr:FilterFrameText;
      
      private var _selfRearAtk:FilterFrameText;
      
      private var _selfRearDef:FilterFrameText;
      
      private var _selfRearAgl:FilterFrameText;
      
      private var _selfRearLuck:FilterFrameText;
      
      private var _selfRearHp:FilterFrameText;
      
      private var _selfRearMAtk:FilterFrameText;
      
      private var _selfRearMDef:FilterFrameText;
      
      private var _selfRearDmg:FilterFrameText;
      
      private var _selfRearAr:FilterFrameText;
      
      private var _refreshBtn:SimpleBitmapButton;
      
      private var _getBuffBtn:SimpleBitmapButton;
      
      private var _getAgainBtn:SimpleBitmapButton;
      
      private var _btnHelp:BaseButton;
      
      private var _lefttime:FilterFrameText;
      
      private var _huafeiMc:MovieClip;
      
      private var _shuziMc:MovieClip;
      
      private var _others:Vector.<PvePowerBuffPerson>;
      
      private var _selectedPlayer:PvePowerBuffPerson;
      
      private var _arBmArr:Array;
      
      public function PvePowerBuffMainView()
      {
         super();
         _initView();
         _initEvent();
      }
      
      private function _initView() : void
      {
         var i:int = 0;
         var __itembg:* = null;
         var __itembgC:* = null;
         var __itemAr:* = null;
         _bg = ComponentFactory.Instance.creat("asset.pvepowerbuff.frame.bg");
         addChild(_bg);
         _others = new Vector.<PvePowerBuffPerson>();
         _refreshOthers();
         _otherForeAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeAtk);
         PositionUtils.setPos(_otherForeAtk,"pvePowerBuff.mainView.otherForeAtk.pos");
         _otherForeAtk.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.attact") + ":";
         _otherForeDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeDef);
         PositionUtils.setPos(_otherForeDef,"pvePowerBuff.mainView.otherForeDef.pos");
         _otherForeDef.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.defense") + ":";
         _otherForeAgl = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeAgl);
         PositionUtils.setPos(_otherForeAgl,"pvePowerBuff.mainView.otherForeAgl.pos");
         _otherForeAgl.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.agility") + ":";
         _otherForeLuck = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeLuck);
         PositionUtils.setPos(_otherForeLuck,"pvePowerBuff.mainView.otherForeLuck.pos");
         _otherForeLuck.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.luck") + ":";
         _otherForeHp = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeHp);
         PositionUtils.setPos(_otherForeHp,"pvePowerBuff.mainView.otherForeHp.pos");
         _otherForeHp.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.hp") + ":";
         _otherForeMAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeMAtk);
         PositionUtils.setPos(_otherForeMAtk,"pvePowerBuff.mainView.otherForeMAtk.pos");
         _otherForeMAtk.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicAttack") + ":";
         _otherForeMDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeMDef);
         PositionUtils.setPos(_otherForeMDef,"pvePowerBuff.mainView.otherForeMDef.pos");
         _otherForeMDef.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicDefence") + ":";
         _otherForeDmg = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeDmg);
         PositionUtils.setPos(_otherForeDmg,"pvePowerBuff.mainView.otherForeDmg.pos");
         _otherForeDmg.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.damage") + ":";
         _otherForeAr = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherForeTxt");
         addChild(_otherForeAr);
         PositionUtils.setPos(_otherForeAr,"pvePowerBuff.mainView.otherForeAr.pos");
         _otherForeAr.text = LanguageMgr.GetTranslation("tank.view.personalinfoII.recovery") + ":";
         _otherRearAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearAtk);
         PositionUtils.setPos(_otherRearAtk,"pvePowerBuff.mainView.otherRearAtk.pos");
         _otherRearDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearDef);
         PositionUtils.setPos(_otherRearDef,"pvePowerBuff.mainView.otherRearDef.pos");
         _otherRearAgl = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearAgl);
         PositionUtils.setPos(_otherRearAgl,"pvePowerBuff.mainView.otherRearAgl.pos");
         _otherRearLuck = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearLuck);
         PositionUtils.setPos(_otherRearLuck,"pvePowerBuff.mainView.otherRearLuck.pos");
         _otherRearHp = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearHp);
         PositionUtils.setPos(_otherRearHp,"pvePowerBuff.mainView.otherRearHp.pos");
         _otherRearMAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearMAtk);
         PositionUtils.setPos(_otherRearMAtk,"pvePowerBuff.mainView.otherRearMAtk.pos");
         _otherRearMDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearMDef);
         PositionUtils.setPos(_otherRearMDef,"pvePowerBuff.mainView.otherRearMDef.pos");
         _otherRearDmg = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearDmg);
         PositionUtils.setPos(_otherRearDmg,"pvePowerBuff.mainView.otherRearDmg.pos");
         _otherRearAr = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.otherRearTxt");
         addChild(_otherRearAr);
         PositionUtils.setPos(_otherRearAr,"pvePowerBuff.mainView.otherRearAr.pos");
         _arBmArr = [];
         for(i = 0; i < 9; )
         {
            __itembg = ComponentFactory.Instance.creat("asset.pvepowerbuff.attribute.item.bg");
            __itembgC = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainview.item.TipContent");
            switch(int(i))
            {
               case 0:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.attact");
                  break;
               case 1:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.defense");
                  break;
               case 2:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.agility");
                  break;
               case 3:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.luck");
                  break;
               case 4:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.hp");
                  break;
               case 5:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicAttack");
                  break;
               case 6:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.magicDefence");
                  break;
               case 7:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.damage");
                  break;
               case 8:
                  __itembgC.tipData = LanguageMgr.GetTranslation("tank.view.personalinfoII.recovery");
            }
            __itembgC.addChild(__itembg);
            addChild(__itembgC);
            __itembgC.x = 668;
            __itembgC.y = 34 + 28 * i;
            __itemAr = ComponentFactory.Instance.creat("asset.pvepowerbuff.uparrow");
            __itemAr.visible = false;
            addChild(__itemAr);
            __itemAr.x = 774;
            __itemAr.y = 37 + 28 * i;
            _arBmArr[i] = __itemAr;
            i++;
         }
         _atkIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.atk");
         addChild(_atkIconBm);
         _defIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.def");
         addChild(_defIconBm);
         _aglIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.agile");
         addChild(_aglIconBm);
         _luckIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.luck");
         addChild(_luckIconBm);
         _hpIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.hp");
         addChild(_hpIconBm);
         _matkIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.matk");
         addChild(_matkIconBm);
         _mdefIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.mdef");
         addChild(_mdefIconBm);
         _dmgIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.damage");
         addChild(_dmgIconBm);
         _arIconBm = ComponentFactory.Instance.creat("asset.pvepowerbuff.icon.armor");
         addChild(_arIconBm);
         _selfForeAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeAtk);
         PositionUtils.setPos(_selfForeAtk,"pvePowerBuff.mainView.selfForeAtk.pos");
         _selfForeAtk.text = PlayerManager.Instance.Self.Attack.toString();
         _selfForeDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeDef);
         PositionUtils.setPos(_selfForeDef,"pvePowerBuff.mainView.selfForeDef.pos");
         _selfForeDef.text = PlayerManager.Instance.Self.Defence.toString();
         _selfForeAgl = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeAgl);
         PositionUtils.setPos(_selfForeAgl,"pvePowerBuff.mainView.selfForeAgl.pos");
         _selfForeAgl.text = PlayerManager.Instance.Self.Agility.toString();
         _selfForeLuck = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeLuck);
         PositionUtils.setPos(_selfForeLuck,"pvePowerBuff.mainView.selfForeLuck.pos");
         _selfForeLuck.text = PlayerManager.Instance.Self.Luck.toString();
         _selfForeHp = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeHp);
         PositionUtils.setPos(_selfForeHp,"pvePowerBuff.mainView.selfForeHp.pos");
         _selfForeHp.text = PlayerManager.Instance.Self.hp.toString();
         _selfForeMAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeMAtk);
         PositionUtils.setPos(_selfForeMAtk,"pvePowerBuff.mainView.selfForeMAtk.pos");
         _selfForeMAtk.text = PlayerManager.Instance.Self.MagicAttack.toString();
         _selfForeMDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeMDef);
         PositionUtils.setPos(_selfForeMDef,"pvePowerBuff.mainView.selfForeMDef.pos");
         _selfForeMDef.text = PlayerManager.Instance.Self.MagicDefence.toString();
         _selfForeDmg = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeDmg);
         PositionUtils.setPos(_selfForeDmg,"pvePowerBuff.mainView.selfForeDmg.pos");
         _selfForeDmg.text = Math.round(StaticFormula.getDamage(PlayerManager.Instance.Self)).toString();
         _selfForeAr = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfForeTxt");
         addChild(_selfForeAr);
         PositionUtils.setPos(_selfForeAr,"pvePowerBuff.mainView.selfForeAr.pos");
         _selfForeAr.text = StaticFormula.getRecovery(PlayerManager.Instance.Self).toString();
         _selfRearAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearAtk);
         PositionUtils.setPos(_selfRearAtk,"pvePowerBuff.mainView.selfRearAtk.pos");
         _selfRearAtk.text = "88888888";
         _selfRearDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearDef);
         PositionUtils.setPos(_selfRearDef,"pvePowerBuff.mainView.selfRearDef.pos");
         _selfRearDef.text = "88888888";
         _selfRearAgl = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearAgl);
         PositionUtils.setPos(_selfRearAgl,"pvePowerBuff.mainView.selfRearAgl.pos");
         _selfRearAgl.text = "88888888";
         _selfRearLuck = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearLuck);
         PositionUtils.setPos(_selfRearLuck,"pvePowerBuff.mainView.selfRearLuck.pos");
         _selfRearLuck.text = "88888888";
         _selfRearHp = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearHp);
         PositionUtils.setPos(_selfRearHp,"pvePowerBuff.mainView.selfRearHp.pos");
         _selfRearHp.text = "88888888";
         _selfRearMAtk = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearMAtk);
         PositionUtils.setPos(_selfRearMAtk,"pvePowerBuff.mainView.selfRearMAtk.pos");
         _selfRearMAtk.text = "88888888";
         _selfRearMDef = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearMDef);
         PositionUtils.setPos(_selfRearMDef,"pvePowerBuff.mainView.selfRearMDef.pos");
         _selfRearMDef.text = "88888888";
         _selfRearDmg = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearDmg);
         PositionUtils.setPos(_selfRearDmg,"pvePowerBuff.mainView.selfRearDmg.pos");
         _selfRearDmg.text = "88888888";
         _selfRearAr = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.selfRearTxt");
         addChild(_selfRearAr);
         PositionUtils.setPos(_selfRearAr,"pvePowerBuff.mainView.selfRearAr.pos");
         _selfRearAr.text = "88888888";
         if(PvePowerBuffManager.instance.getBuffIndex < 0)
         {
            _setSelfRearTxt();
            _setSelfRearTextVisible(false);
            _setOtherPower();
         }
         else
         {
            _setSelfRearTxt(true);
            _setSelfRearTextVisible(true);
            _selectedPlayer = _others[PvePowerBuffManager.instance.getBuffIndex];
            _selectedPlayer.setLightMcVisible(true);
            _setOtherPower(_selectedPlayer.playerInfo);
            _showArrows(true);
         }
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.refreshBtn");
         addChild(_refreshBtn);
         _getBuffBtn = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.getBuffBtn");
         _getBuffBtn.tipData = LanguageMgr.GetTranslation("ddt.pvePowerBuff.getBuffBtn.free");
         addChild(_getBuffBtn);
         _getAgainBtn = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.getAgainBtn");
         _getAgainBtn.tipData = LanguageMgr.GetTranslation("ddt.pvePowerBuff.getBuffBtn.pay",ServerConfigManager.instance.pvePowerBuffGetBuffPrice);
         addChild(_getAgainBtn);
         _refreshButtonTipsData();
         if(PvePowerBuffManager.instance.getBuffCount < 1)
         {
            _getBuffBtn.visible = true;
            _getAgainBtn.visible = false;
         }
         else
         {
            _getBuffBtn.visible = false;
            _getAgainBtn.visible = true;
         }
         _lefttime = ComponentFactory.Instance.creatComponentByStylename("pvePowerBuff.mainView.leftTimeTxt");
         addChild(_lefttime);
         _lefttime.visible = false;
         _setTimeText();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"cardSystem.texpSystem.btnHelp",{
            "x":739,
            "y":-81
         },LanguageMgr.GetTranslation("ddt.pvePowerBuff.helpFrame.title"),"pvePowerBuff.help.content",408,488);
      }
      
      private function _refreshButtonTipsData() : void
      {
         if(PvePowerBuffManager.instance.refreshCount < 2)
         {
            _refreshBtn.tipData = LanguageMgr.GetTranslation("ddt.pvePowerBuff.refreshBtn.free");
         }
         else
         {
            _refreshBtn.tipData = LanguageMgr.GetTranslation("ddt.pvePowerBuff.refreshBtn.pay",ServerConfigManager.instance.pvePowerBuffRefreshPrice);
         }
      }
      
      private function _setOtherPower(info:PlayerInfo = null) : void
      {
         if(info)
         {
            _otherRearAtk.text = info.Attack.toString();
            _otherRearDef.text = info.Defence.toString();
            _otherRearAgl.text = info.Agility.toString();
            _otherRearLuck.text = info.Luck.toString();
            _otherRearHp.text = info.hp.toString();
            _otherRearMAtk.text = info.MagicAttack.toString();
            _otherRearMDef.text = info.MagicDefence.toString();
            _otherRearDmg.text = info.Damage.toString();
            _otherRearAr.text = info.Guard.toString();
         }
         else
         {
            _otherRearAtk.text = "????";
            _otherRearDef.text = "????";
            _otherRearAgl.text = "????";
            _otherRearLuck.text = "????";
            _otherRearHp.text = "????";
            _otherRearMAtk.text = "????";
            _otherRearMDef.text = "????";
            _otherRearDmg.text = "????";
            _otherRearAr.text = "????";
         }
      }
      
      private function _setSelfRearTxt(f:Boolean = false) : void
      {
         if(f == true)
         {
            _selfRearAtk.text = Math.floor(PvePowerBuffManager.instance.getBuffAtk * 0.2).toString();
            _selfRearDef.text = Math.floor(PvePowerBuffManager.instance.getBuffDef * 0.2).toString();
            _selfRearAgl.text = Math.floor(PvePowerBuffManager.instance.getBuffAgl * 0.2).toString();
            _selfRearLuck.text = Math.floor(PvePowerBuffManager.instance.getBuffLuck * 0.2).toString();
            _selfRearHp.text = Math.floor(PvePowerBuffManager.instance.getBuffHp * 0.2).toString();
            _selfRearMAtk.text = Math.floor(PvePowerBuffManager.instance.getBuffMAtk * 0.2).toString();
            _selfRearMDef.text = Math.floor(PvePowerBuffManager.instance.getBuffMDef * 0.2).toString();
            _selfRearDmg.text = Math.floor(PvePowerBuffManager.instance.getBuffDmg * 0.2).toString();
            _selfRearAr.text = Math.floor(PvePowerBuffManager.instance.getBuffAr * 0.2).toString();
         }
      }
      
      private function _setSelfRearTextVisible(v:Boolean) : void
      {
         var _loc2_:* = v;
         _selfRearAr.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearDmg.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearMDef.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearMAtk.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearHp.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearLuck.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearAgl.visible = _loc2_;
         _loc2_ = _loc2_;
         _selfRearDef.visible = _loc2_;
         _selfRearAtk.visible = _loc2_;
      }
      
      private function _setTimeText() : void
      {
         var getD:* = null;
         var nowTime:* = null;
         var tic:Number = NaN;
         var m:Number = NaN;
         if(PvePowerBuffManager.instance.getBuffCount > 0 && PvePowerBuffManager.instance.getBuffDate != null)
         {
            getD = PvePowerBuffManager.instance.getBuffDate;
            nowTime = TimeManager.Instance.Now();
            tic = nowTime.getTime() - getD.getTime();
            m = 30 - Math.floor(tic / 60000);
            _lefttime.text = LanguageMgr.GetTranslation("ddt.pvePowerBuff.buff.left.time.text",m < 0?0:Number(m));
            _lefttime.visible = true;
         }
      }
      
      private function _refreshOthers() : void
      {
         var c:int = 0;
         var pvePowerBuffPlayer:* = null;
         while(_others.length)
         {
            removeChild(_others[0]);
            _others[0] = null;
            _others.shift();
         }
         var playerInfoVc:Vector.<PlayerInfo> = PvePowerBuffManager.instance.playerInfoVc;
         for(c = 0; c < playerInfoVc.length; )
         {
            pvePowerBuffPlayer = new PvePowerBuffPerson(c);
            pvePowerBuffPlayer.updatePlayer(playerInfoVc[c]);
            addChild(pvePowerBuffPlayer);
            PositionUtils.setPos(pvePowerBuffPlayer,"pvePowerBuff.mainView.character." + c + ".pos");
            _others.push(pvePowerBuffPlayer);
            c++;
         }
         PvePowerBuffManager.instance.isInRefresh = false;
      }
      
      private function _removeOthers() : void
      {
      }
      
      private function _initEvent() : void
      {
         PvePowerBuffControl.instance.addEventListener("select_player",__selectPlayerHandler);
         PvePowerBuffManager.instance.addEventListener("pvepowerbuff_refresh",__refreshBuffHandler);
         PvePowerBuffManager.instance.addEventListener("pvepowerbuff_getbuff",__getBuffHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _getBuffBtn.addEventListener("click",__getBuffBtnClickHandler);
         _getAgainBtn.addEventListener("click",__getAgainBtnClickHandler);
      }
      
      private function __selectPlayerHandler(e:PvePowerBuffEvent) : void
      {
         if(_selectedPlayer)
         {
            _selectedPlayer.setLightMcVisible(false);
         }
         _selectedPlayer = e.info;
         _selectedPlayer.setLightMcVisible(true);
         _setOtherPower(_selectedPlayer.playerInfo);
      }
      
      private function __refreshBuffHandler(e:PvePowerBuffEvent) : void
      {
         _selectedPlayer = null;
         _refreshButtonTipsData();
         _refreshOthers();
      }
      
      private function __getBuffHandler(e:PvePowerBuffEvent) : void
      {
         PvePowerBuffManager.instance.isInGetBuff = true;
         if(_huafeiMc)
         {
            _huafeiMc = null;
         }
         _huafeiMc = ClassUtils.CreatInstance("asset.pvepowerbuff.hua.fei.mc");
         PositionUtils.setPos(_huafeiMc,"pvePowerBuff.mainView.huafei." + PvePowerBuffManager.instance.getBuffIndex + ".pos");
         addChild(_huafeiMc);
         var tweenline:TimelineLite = new TimelineLite({"onComplete":_tweenCompleteHua});
         tweenline.append(TweenLite.to(_huafeiMc,1,{
            "scaleX":1,
            "scaleY":1,
            "x":_huafeiMc.x,
            "y":_huafeiMc.y
         }));
         tweenline.append(TweenLite.to(_huafeiMc,2,{
            "scaleX":1,
            "scaleY":1,
            "x":670,
            "y":255
         }));
      }
      
      private function _tweenCompleteHua() : void
      {
         removeChild(_huafeiMc);
         _huafeiMc = null;
         _shuziMc = ClassUtils.CreatInstance("asset.pvepowerbuff.quare.light.mc");
         PositionUtils.setPos(_shuziMc,"pvePowerBuff.character.shuzi.mc.pos");
         addChild(_shuziMc);
         var tweenline:TimelineLite = new TimelineLite({"onComplete":_shuziKuang});
         tweenline.append(TweenLite.to(_shuziMc,1,{
            "scaleX":1,
            "scaleY":1,
            "x":_shuziMc.x,
            "y":_shuziMc.y
         }));
      }
      
      private function _shuziKuang() : void
      {
         removeChild(_shuziMc);
         _shuziMc = null;
         _setSelfRearTextVisible(true);
         _showArrows(true);
         _setSelfRearTxt(true);
         _setTimeText();
         if(_getBuffBtn.visible == true)
         {
            _getBuffBtn.visible = false;
            _getAgainBtn.visible = true;
         }
         else
         {
            _getAgainBtn.enable = true;
         }
         PvePowerBuffManager.instance.isInGetBuff = false;
      }
      
      private function _showArrows(v:Boolean = false) : void
      {
         var i:int = 0;
         for(i = 0; i < _arBmArr.length; )
         {
            _arBmArr[i].visible = v;
            i++;
         }
      }
      
      private function __onRefreshResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onRefreshResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            SocketManager.Instance.out.pvePowerBuffRefresh();
         }
         frame.dispose();
      }
      
      private function __refreshBtnClickHandler(e:MouseEvent) : void
      {
         var frame:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PvePowerBuffManager.instance.refreshCount < 2)
         {
            SocketManager.Instance.out.pvePowerBuffRefresh();
         }
         else
         {
            if(PlayerManager.Instance.Self.Money < ServerConfigManager.instance.pvePowerBuffRefreshPrice)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pvePowerBuff.refreshBtn.pay",ServerConfigManager.instance.pvePowerBuffRefreshPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            frame.addEventListener("response",__onRefreshResponse);
         }
      }
      
      private function __getBuffBtnClickHandler(e:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_selectedPlayer == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pvePowerBuff.getBuff.noIndex"));
            return;
         }
         _getBuffBtn.enable = false;
         SocketManager.Instance.out.pvePowerBuffGetBuff(_selectedPlayer.index);
      }
      
      private function __getAgainBtnClickHandler(e:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_selectedPlayer == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pvePowerBuff.getBuff.noIndex"));
            return;
         }
         if(PlayerManager.Instance.Self.Money < ServerConfigManager.instance.pvePowerBuffGetBuffPrice)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         _getAgainBtn.enable = false;
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.pvePowerBuff.getBuffBtn.pay",ServerConfigManager.instance.pvePowerBuffGetBuffPrice),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         frame.addEventListener("response",__onGetAgainResponse);
      }
      
      private function __onGetAgainResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onGetAgainResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            SocketManager.Instance.out.pvePowerBuffGetBuff(_selectedPlayer.index);
         }
         else if(e.responseCode == 4 || e.responseCode == 0 || e.responseCode == 1)
         {
            _getAgainBtn.enable = true;
         }
         frame.dispose();
      }
      
      private function _removeEvent() : void
      {
         PvePowerBuffControl.instance.removeEventListener("select_player",__selectPlayerHandler);
         PvePowerBuffManager.instance.removeEventListener("pvepowerbuff_refresh",__refreshBuffHandler);
         PvePowerBuffManager.instance.removeEventListener("pvepowerbuff_getbuff",__getBuffHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _getBuffBtn.removeEventListener("click",__getBuffBtnClickHandler);
         _getAgainBtn.removeEventListener("click",__getAgainBtnClickHandler);
      }
      
      public function dispose() : void
      {
         _removeEvent();
         _removeOthers();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_otherForeAtk);
         _otherForeAtk = null;
         ObjectUtils.disposeObject(_otherForeDef);
         _otherForeDef = null;
         ObjectUtils.disposeObject(_otherForeAgl);
         _otherForeAgl = null;
         ObjectUtils.disposeObject(_otherForeLuck);
         _otherForeLuck = null;
         ObjectUtils.disposeObject(_otherForeHp);
         _otherForeHp = null;
         ObjectUtils.disposeObject(_otherForeMAtk);
         _otherForeMAtk = null;
         ObjectUtils.disposeObject(_otherForeMDef);
         _otherForeMDef = null;
         ObjectUtils.disposeObject(_otherForeDmg);
         _otherForeDmg = null;
         ObjectUtils.disposeObject(_otherForeAr);
         _otherForeAr = null;
         ObjectUtils.disposeObject(_otherRearAtk);
         _otherRearAtk = null;
         ObjectUtils.disposeObject(_otherRearDef);
         _otherRearDef = null;
         ObjectUtils.disposeObject(_otherRearAgl);
         _otherRearAgl = null;
         ObjectUtils.disposeObject(_otherRearLuck);
         _otherRearLuck = null;
         ObjectUtils.disposeObject(_otherRearHp);
         _otherRearHp = null;
         ObjectUtils.disposeObject(_otherRearMAtk);
         _otherRearMAtk = null;
         ObjectUtils.disposeObject(_otherRearMDef);
         _otherRearMDef = null;
         ObjectUtils.disposeObject(_otherRearDmg);
         _otherRearDmg = null;
         ObjectUtils.disposeObject(_otherRearAr);
         _otherRearAr = null;
         ObjectUtils.disposeObject(_atkIconBm);
         _atkIconBm = null;
         ObjectUtils.disposeObject(_defIconBm);
         _defIconBm = null;
         ObjectUtils.disposeObject(_aglIconBm);
         _aglIconBm = null;
         ObjectUtils.disposeObject(_luckIconBm);
         _luckIconBm = null;
         ObjectUtils.disposeObject(_hpIconBm);
         _hpIconBm = null;
         ObjectUtils.disposeObject(_matkIconBm);
         _matkIconBm = null;
         ObjectUtils.disposeObject(_mdefIconBm);
         _mdefIconBm = null;
         ObjectUtils.disposeObject(_dmgIconBm);
         _dmgIconBm = null;
         ObjectUtils.disposeObject(_arIconBm);
         _arIconBm = null;
         ObjectUtils.disposeObject(_selfForeAtk);
         _selfForeAtk = null;
         ObjectUtils.disposeObject(_selfForeDef);
         _selfForeDef = null;
         ObjectUtils.disposeObject(_selfForeAgl);
         _selfForeAgl = null;
         ObjectUtils.disposeObject(_selfForeLuck);
         _selfForeLuck = null;
         ObjectUtils.disposeObject(_selfForeHp);
         _selfForeHp = null;
         ObjectUtils.disposeObject(_selfForeMAtk);
         _selfForeMAtk = null;
         ObjectUtils.disposeObject(_selfForeMDef);
         _selfForeMDef = null;
         ObjectUtils.disposeObject(_selfForeDmg);
         _selfForeDmg = null;
         ObjectUtils.disposeObject(_selfForeAr);
         _selfForeAr = null;
         ObjectUtils.disposeObject(_selfRearAtk);
         _selfRearAtk = null;
         ObjectUtils.disposeObject(_selfRearDef);
         _selfRearDef = null;
         ObjectUtils.disposeObject(_selfRearAgl);
         _selfRearAgl = null;
         ObjectUtils.disposeObject(_selfRearLuck);
         _selfRearLuck = null;
         ObjectUtils.disposeObject(_selfRearHp);
         _selfRearHp = null;
         ObjectUtils.disposeObject(_selfRearMAtk);
         _selfRearMAtk = null;
         ObjectUtils.disposeObject(_selfRearMDef);
         _selfRearMDef = null;
         ObjectUtils.disposeObject(_selfRearDmg);
         _selfRearDmg = null;
         ObjectUtils.disposeObject(_selfRearAr);
         _selfRearAr = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_getBuffBtn);
         _getBuffBtn = null;
         ObjectUtils.disposeObject(_getAgainBtn);
         _getAgainBtn = null;
         ObjectUtils.disposeObject(_lefttime);
         _lefttime = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         if(_huafeiMc)
         {
            removeChild(_huafeiMc);
            _huafeiMc = null;
         }
         if(_shuziMc)
         {
            removeChild(_shuziMc);
            _shuziMc = null;
         }
      }
   }
}
