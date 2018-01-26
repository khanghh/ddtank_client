package rank.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import rank.RankManager;
   import rank.data.RankAwardInfo;
   import rank.data.RankLayouInfo;
   
   public class RankInfoFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var rankTitleNameList:Array;
      
      private var type:int;
      
      private var titleBox:Sprite;
      
      private var itemBox:Sprite;
      
      private var _lastRefreshInfo:FilterFrameText;
      
      public function RankInfoFrame(){super();}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      protected function _responseHandle(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.manager.ItemManager;
import ddt.manager.LanguageMgr;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import horse.HorseManager;
import rank.data.RankAwardInfo;
import rank.data.RankLayouInfo;
import tofflist.data.TofflistPlayerInfo;
import totem.TotemManager;

class RankInfoItem extends Sprite
{
    
   
   function RankInfoItem(param1:int, param2:RankAwardInfo){super();}
}
