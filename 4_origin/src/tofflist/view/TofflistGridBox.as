package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import tofflist.data.TofflistLayoutInfo;
   
   public class TofflistGridBox extends Sprite implements Disposeable
   {
      
      private static const RANK:String = LanguageMgr.GetTranslation("repute");
      
      private static const NAME:String = LanguageMgr.GetTranslation("civil.rightview.listname");
      
      private static const BATTLE:String = LanguageMgr.GetTranslation("tank.menu.FightPoweTxt");
      
      private static const LEVEL:String = LanguageMgr.GetTranslation("tank.menu.LevelTxt");
      
      private static const EXP:String = LanguageMgr.GetTranslation("exp");
      
      private static const CHARM_LEVEL:String = LanguageMgr.GetTranslation("tofflist.charmLevel");
      
      private static const CHARM_VALUE:String = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
      
      private static const SCORE:String = LanguageMgr.GetTranslation("tofflist.battleScore");
      
      private static const ACHIVE_POINT:String = LanguageMgr.GetTranslation("tofflist.achivepoint");
      
      private static const ASSET:String = LanguageMgr.GetTranslation("consortia.Money");
      
      private static const TOTAL_ASSET:String = LanguageMgr.GetTranslation("tofflist.totalasset");
      
      private static const SERVER:String = LanguageMgr.GetTranslation("tofflist.server");
      
      private static const MOUNTSNAME:String = LanguageMgr.GetTranslation("tofflist.mountsname");
      
      private static const MOUNTSLEVEL:String = LanguageMgr.GetTranslation("tofflist.mountslevel");
      
      private static const MOUNTSHOST:String = LanguageMgr.GetTranslation("tofflist.mountshost");
      
      private static const TEAMINTEGRAL:String = LanguageMgr.GetTranslation("team.rank.score");
      
      private static const TEAMNAME:String = LanguageMgr.GetTranslation("team.rank.name");
      
      private static const TEAMSEGMENT:String = LanguageMgr.GetTranslation("team.rank.segment");
       
      
      private var _bg:MutipleImage;
      
      private var _titleBg:MutipleImage;
      
      private var _layoutInfoArr:Dictionary;
      
      private var _title:Sprite;
      
      private var _orderList:TofflistOrderList;
      
      private var _id:String;
      
      public function TofflistGridBox()
      {
         super();
         _layoutInfoArr = new Dictionary();
         initData();
         _bg = ComponentFactory.Instance.creatComponentByStylename("tofflist.right.listBg");
         addChild(_bg);
         _title = new Sprite();
         addChild(_title);
         _orderList = new TofflistOrderList();
         PositionUtils.setPos(_orderList,"tofflist.orderlistPos");
         addChild(_orderList);
      }
      
      private function initData() : void
      {
         var person_local_battle:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_battle");
         person_local_battle.TitleTextString = [RANK,NAME,BATTLE];
         _layoutInfoArr["personLocalBattle"] = person_local_battle;
         var person_local_level:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_level");
         person_local_level.TitleTextString = [RANK,NAME,LEVEL,EXP];
         _layoutInfoArr["personLocalLevel"] = person_local_level;
         var person_local_achive:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_achive");
         person_local_achive.TitleTextString = [RANK,NAME,ACHIVE_POINT];
         _layoutInfoArr["personLocalAchive"] = person_local_achive;
         var person_local_charm:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_charm");
         person_local_charm.TitleTextString = [RANK,NAME,CHARM_LEVEL,CHARM_VALUE];
         _layoutInfoArr["personLocalCharm"] = person_local_charm;
         var person_local_match:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_match");
         person_local_match.TitleTextString = [RANK,NAME,SCORE];
         _layoutInfoArr["personLocalMatch"] = person_local_match;
         var person_local_mounts:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_mounts");
         person_local_mounts.TitleTextString = [RANK,MOUNTSNAME,MOUNTSLEVEL,MOUNTSHOST];
         _layoutInfoArr["personLocalMounts"] = person_local_mounts;
         var person_cross_battle:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_battle");
         person_cross_battle.TitleTextString = [RANK,NAME,SERVER,BATTLE];
         _layoutInfoArr["personCrossBattle"] = person_cross_battle;
         var person_cross_level:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_level");
         person_cross_level.TitleTextString = [RANK,NAME,LEVEL,SERVER,EXP];
         _layoutInfoArr["personCrossLevel"] = person_cross_level;
         var person_cross_achive:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_achive");
         person_cross_achive.TitleTextString = [RANK,NAME,SERVER,ACHIVE_POINT];
         _layoutInfoArr["personCrossAchive"] = person_cross_achive;
         var person_cross_charm:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_charm");
         person_cross_charm.TitleTextString = [RANK,NAME,CHARM_LEVEL,SERVER,CHARM_VALUE];
         _layoutInfoArr["personCrossCharm"] = person_cross_charm;
         var person_cross_mounts:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_mounts");
         person_cross_mounts.TitleTextString = [RANK,MOUNTSNAME,MOUNTSLEVEL,SERVER,MOUNTSHOST];
         _layoutInfoArr["personCrossMounts"] = person_cross_mounts;
         var consortia_local_battle:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_battle");
         consortia_local_battle.TitleTextString = [RANK,NAME,BATTLE];
         _layoutInfoArr["consortiaLocalBattle"] = consortia_local_battle;
         var consortia_local_level:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_level");
         consortia_local_level.TitleTextString = [RANK,NAME,LEVEL,ASSET];
         _layoutInfoArr["consortiaLocalLevel"] = consortia_local_level;
         var consortia_local_asset:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_asset");
         consortia_local_asset.TitleTextString = [RANK,NAME,TOTAL_ASSET];
         _layoutInfoArr["consortiaLocalAsset"] = consortia_local_asset;
         var consortia_local_charm:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_charm");
         consortia_local_charm.TitleTextString = [RANK,NAME,CHARM_VALUE];
         _layoutInfoArr["consortiaLocalCharm"] = consortia_local_charm;
         var consortia_cross_battle:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_battle");
         consortia_cross_battle.TitleTextString = [RANK,NAME,SERVER,BATTLE];
         _layoutInfoArr["consortiaCrossBattle"] = consortia_cross_battle;
         var consortia_cross_level:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_level");
         consortia_cross_level.TitleTextString = [RANK,NAME,LEVEL,SERVER,ASSET];
         _layoutInfoArr["consortiaCrossLevel"] = consortia_cross_level;
         var consortia_cross_asset:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_asset");
         consortia_cross_asset.TitleTextString = [RANK,NAME,SERVER,TOTAL_ASSET];
         _layoutInfoArr["consortiaCrossAsset"] = consortia_cross_asset;
         var consortia_cross_charm:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_charm");
         consortia_cross_charm.TitleTextString = [RANK,NAME,SERVER,CHARM_VALUE];
         _layoutInfoArr["consortiaCrossCharm"] = consortia_cross_charm;
         var team_local:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("team_local");
         team_local.TitleTextString = [RANK,TEAMNAME,TEAMSEGMENT,TEAMINTEGRAL];
         _layoutInfoArr["teamThe"] = team_local;
         var team_cross:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("team_cross");
         team_cross.TitleTextString = [RANK,TEAMNAME,TEAMSEGMENT,SERVER,TEAMINTEGRAL];
         _layoutInfoArr["teamCross"] = team_cross;
      }
      
      public function get orderList() : TofflistOrderList
      {
         return _orderList;
      }
      
      public function updateList(list:Array, page:int = 1) : void
      {
         var layoutinfo:* = null;
         _orderList.items(list,page);
         if(_id)
         {
            layoutinfo = _layoutInfoArr[_id];
            _orderList.showHline(layoutinfo.TitleHLinePoint);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function updateStyleXY($id:String) : void
      {
         var line:* = null;
         var i:int = 0;
         var txt:* = null;
         _id = $id;
         ObjectUtils.disposeAllChildren(_title);
         var layoutinfo:TofflistLayoutInfo = _layoutInfoArr[$id];
         var _loc8_:int = 0;
         var _loc7_:* = layoutinfo.TitleHLinePoint;
         for each(var pt in layoutinfo.TitleHLinePoint)
         {
            line = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
            PositionUtils.setPos(line,pt);
            _title.addChild(line);
         }
         for(i = 0; i < layoutinfo.TitleTextPoint.length; )
         {
            txt = ComponentFactory.Instance.creatComponentByStylename("toffilist.listTitleText");
            PositionUtils.setPos(txt,layoutinfo.TitleTextPoint[i]);
            txt.text = layoutinfo.TitleTextString[i];
            _title.addChild(txt);
            i++;
         }
      }
   }
}
