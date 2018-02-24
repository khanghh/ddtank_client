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
      
      public function TofflistGridBox(){super();}
      
      private function initData() : void{}
      
      public function get orderList() : TofflistOrderList{return null;}
      
      public function updateList(param1:Array, param2:int = 1) : void{}
      
      public function dispose() : void{}
      
      public function updateStyleXY(param1:String) : void{}
   }
}
