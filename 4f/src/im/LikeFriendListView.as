package im
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.LikeFriendAnalyzer;
   import ddt.data.player.LikeFriendInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.RequestVairableCreater;
   import flash.display.Sprite;
   import flash.net.URLVariables;
   
   public class LikeFriendListView extends Sprite implements Disposeable
   {
       
      
      private var _list:ListPanel;
      
      private var _likeFriendList:Array;
      
      private var _currentItem:LikeFriendInfo;
      
      private var _pos:int;
      
      public function LikeFriendListView(){super();}
      
      public function get likeFriendList() : Array{return null;}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function creatItemTempleteLoader() : BaseLoader{return null;}
      
      private function __loadComplete(param1:LikeFriendAnalyzer) : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function __updateList() : void{}
      
      private function update() : void{}
      
      public function dispose() : void{}
   }
}
