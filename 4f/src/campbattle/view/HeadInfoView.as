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
      
      public function HeadInfoView(param1:PlayerInfo){super();}
      
      private function initView() : void{}
      
      private function characterComplete(param1:Event) : void{}
      
      private function pevCountHander(param1:MapEvent) : void{}
      
      public function updateScore(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
