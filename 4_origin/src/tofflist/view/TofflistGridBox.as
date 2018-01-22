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
         var _loc15_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_battle");
         _loc15_.TitleTextString = [RANK,NAME,BATTLE];
         _layoutInfoArr["personLocalBattle"] = _loc15_;
         var _loc21_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_level");
         _loc21_.TitleTextString = [RANK,NAME,LEVEL,EXP];
         _layoutInfoArr["personLocalLevel"] = _loc21_;
         var _loc5_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_achive");
         _loc5_.TitleTextString = [RANK,NAME,ACHIVE_POINT];
         _layoutInfoArr["personLocalAchive"] = _loc5_;
         var _loc14_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_charm");
         _loc14_.TitleTextString = [RANK,NAME,CHARM_LEVEL,CHARM_VALUE];
         _layoutInfoArr["personLocalCharm"] = _loc14_;
         var _loc18_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_match");
         _loc18_.TitleTextString = [RANK,NAME,SCORE];
         _layoutInfoArr["personLocalMatch"] = _loc18_;
         var _loc19_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_local_mounts");
         _loc19_.TitleTextString = [RANK,MOUNTSNAME,MOUNTSLEVEL,MOUNTSHOST];
         _layoutInfoArr["personLocalMounts"] = _loc19_;
         var _loc12_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_battle");
         _loc12_.TitleTextString = [RANK,NAME,SERVER,BATTLE];
         _layoutInfoArr["personCrossBattle"] = _loc12_;
         var _loc20_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_level");
         _loc20_.TitleTextString = [RANK,NAME,LEVEL,SERVER,EXP];
         _layoutInfoArr["personCrossLevel"] = _loc20_;
         var _loc10_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_achive");
         _loc10_.TitleTextString = [RANK,NAME,SERVER,ACHIVE_POINT];
         _layoutInfoArr["personCrossAchive"] = _loc10_;
         var _loc4_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_charm");
         _loc4_.TitleTextString = [RANK,NAME,CHARM_LEVEL,SERVER,CHARM_VALUE];
         _layoutInfoArr["personCrossCharm"] = _loc4_;
         var _loc9_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("person_cross_mounts");
         _loc9_.TitleTextString = [RANK,MOUNTSNAME,MOUNTSLEVEL,SERVER,MOUNTSHOST];
         _layoutInfoArr["personCrossMounts"] = _loc9_;
         var _loc13_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_battle");
         _loc13_.TitleTextString = [RANK,NAME,BATTLE];
         _layoutInfoArr["consortiaLocalBattle"] = _loc13_;
         var _loc6_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_level");
         _loc6_.TitleTextString = [RANK,NAME,LEVEL,ASSET];
         _layoutInfoArr["consortiaLocalLevel"] = _loc6_;
         var _loc1_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_asset");
         _loc1_.TitleTextString = [RANK,NAME,TOTAL_ASSET];
         _layoutInfoArr["consortiaLocalAsset"] = _loc1_;
         var _loc3_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_local_charm");
         _loc3_.TitleTextString = [RANK,NAME,CHARM_VALUE];
         _layoutInfoArr["consortiaLocalCharm"] = _loc3_;
         var _loc16_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_battle");
         _loc16_.TitleTextString = [RANK,NAME,SERVER,BATTLE];
         _layoutInfoArr["consortiaCrossBattle"] = _loc16_;
         var _loc8_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_level");
         _loc8_.TitleTextString = [RANK,NAME,LEVEL,SERVER,ASSET];
         _layoutInfoArr["consortiaCrossLevel"] = _loc8_;
         var _loc7_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_asset");
         _loc7_.TitleTextString = [RANK,NAME,SERVER,TOTAL_ASSET];
         _layoutInfoArr["consortiaCrossAsset"] = _loc7_;
         var _loc2_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("consortia_cross_charm");
         _loc2_.TitleTextString = [RANK,NAME,SERVER,CHARM_VALUE];
         _layoutInfoArr["consortiaCrossCharm"] = _loc2_;
         var _loc17_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("team_local");
         _loc17_.TitleTextString = [RANK,TEAMNAME,TEAMSEGMENT,TEAMINTEGRAL];
         _layoutInfoArr["teamThe"] = _loc17_;
         var _loc11_:TofflistLayoutInfo = ComponentFactory.Instance.creatCustomObject("team_cross");
         _loc11_.TitleTextString = [RANK,TEAMNAME,TEAMSEGMENT,SERVER,TEAMINTEGRAL];
         _layoutInfoArr["teamCross"] = _loc11_;
      }
      
      public function get orderList() : TofflistOrderList
      {
         return _orderList;
      }
      
      public function updateList(param1:Array, param2:int = 1) : void
      {
         var _loc3_:* = null;
         _orderList.items(param1,param2);
         if(_id)
         {
            _loc3_ = _layoutInfoArr[_id];
            _orderList.showHline(_loc3_.TitleHLinePoint);
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
      
      public function updateStyleXY(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         _id = param1;
         ObjectUtils.disposeAllChildren(_title);
         var _loc2_:TofflistLayoutInfo = _layoutInfoArr[param1];
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_.TitleHLinePoint;
         for each(var _loc3_ in _loc2_.TitleHLinePoint)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
            PositionUtils.setPos(_loc4_,_loc3_);
            _title.addChild(_loc4_);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.TitleTextPoint.length)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("toffilist.listTitleText");
            PositionUtils.setPos(_loc5_,_loc2_.TitleTextPoint[_loc6_]);
            _loc5_.text = _loc2_.TitleTextString[_loc6_];
            _title.addChild(_loc5_);
            _loc6_++;
         }
      }
   }
}
