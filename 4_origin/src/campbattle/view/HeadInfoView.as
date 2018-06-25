package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.event.MapEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.StaticFormula;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HeadInfoView extends Sprite
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _backPic:Bitmap;
      
      private var _blood:Bitmap;
      
      private var _info:PlayerInfo;
      
      private var _character:ShowCharacter;
      
      private var _nameTxt:FilterFrameText;
      
      private var _bloodTxt:FilterFrameText;
      
      private var _teamTxt:FilterFrameText;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _currtAct:FilterFrameText;
      
      private var _capList:Array;
      
      private var _figure:Bitmap;
      
      private var _directrion:String = "left";
      
      public function HeadInfoView(info:PlayerInfo)
      {
         _capList = ["",LanguageMgr.GetTranslation("ddt.campBattle.qinglong"),LanguageMgr.GetTranslation("ddt.campBattle.baihu"),LanguageMgr.GetTranslation("ddt.campBattle.zhuque"),LanguageMgr.GetTranslation("ddt.campBattle.xuanwu")];
         super();
         _info = info;
         initView();
      }
      
      private function initView() : void
      {
         _backPic = ComponentFactory.Instance.creat("camp.campBattle.humanTitle");
         addChild(_backPic);
         _blood = ComponentFactory.Instance.creat("camp.campBattle.humanred");
         addChild(_blood);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.headName");
         _nameTxt.text = _info.NickName;
         addChild(_nameTxt);
         var max:int = StaticFormula.getMaxHp(_info);
         _bloodTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.headBlood");
         _bloodTxt.text = max + "/" + max;
         addChild(_bloodTxt);
         _teamTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.headTeamInfo");
         _teamTxt.text = _capList[CampBattleControl.instance.model.myTeam];
         addChild(_teamTxt);
         _myScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.headSocre");
         _myScoreTxt.text = CampBattleControl.instance.model.myScore.toString();
         addChild(_myScoreTxt);
         _currtAct = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.headAct");
         _currtAct.text = CampBattleControl.instance.model.monsterCount.toString();
         addChild(_currtAct);
         _character = CharactoryFactory.createCharacter(_info,"show") as ShowCharacter;
         _character.showGun = false;
         _character.setShowLight(false,null);
         _character.stopAnimation();
         _character.show(true,1);
         _character.addEventListener("complete",characterComplete);
         CampBattleControl.instance.addEventListener("pve_count",pevCountHander);
      }
      
      private function characterComplete(evt:Event) : void
      {
         var maskSp:* = null;
         if(_figure && _figure.parent && _figure.bitmapData)
         {
            _figure.parent.removeChild(_figure);
            _figure.bitmapData.dispose();
            _figure = null;
         }
         if(!_character.info.getShowSuits())
         {
            _figure = new Bitmap(new BitmapData(200,150));
            _figure.bitmapData.copyPixels(_character.characterBitmapdata,new Rectangle(0,60,200,150),new Point(0,0));
            _figure.scaleX = 0.45 * (_directrion == "left"?1:-1);
            _figure.scaleY = 0.45;
            _figure.x = _directrion == "left"?0:82;
            _figure.y = 12;
         }
         else
         {
            _figure = new Bitmap(new BitmapData(200,200));
            _figure.bitmapData.copyPixels(_character.characterBitmapdata,new Rectangle(0,10,200,200),new Point(0,0));
            _figure.scaleX = 0.35 * (_directrion == "left"?1:-1);
            _figure.scaleY = 0.35;
            _figure.x = _directrion == "left"?18:73;
            _figure.y = 12;
            maskSp = ComponentFactory.Instance.creat("camp.battle.headmask");
            maskSp.x = 49;
            maskSp.y = 50;
            addChild(maskSp);
            _figure.mask = maskSp;
         }
         addChild(_figure);
      }
      
      private function pevCountHander(e:MapEvent) : void
      {
         _currtAct.text = CampBattleControl.instance.model.monsterCount.toString();
      }
      
      public function updateScore(score:int) : void
      {
         _myScoreTxt.text = score.toString();
      }
      
      public function dispose() : void
      {
         _character.removeEventListener("complete",characterComplete);
         CampBattleControl.instance.removeEventListener("pve_count",pevCountHander);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
