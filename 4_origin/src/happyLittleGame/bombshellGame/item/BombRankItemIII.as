package happyLittleGame.bombshellGame.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   
   public class BombRankItemIII extends Sprite implements Disposeable
   {
       
      
      private var _ranking:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _rank:int;
      
      private var _info:BombRankInfo;
      
      private var _nameDis:String;
      
      private var _tipbackgound:Image;
      
      private var _tipDis:FilterFrameText;
      
      public function BombRankItemIII()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _ranking = ComponentFactory.Instance.creatComponentByStylename("bombgame.bomb.commoneTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.bomb.commoneTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.bomb.commoneTxt");
         _tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _tipbackgound.width = 200;
         _tipbackgound.height = 30;
         _tipbackgound.y = -30;
         _tipbackgound.x = 40;
         _tipbackgound.visible = false;
         _tipDis = ComponentFactory.Instance.creatComponentByStylename("bombgame.rank.name");
         _tipDis.width = 200;
         _tipDis.visible = false;
         _tipDis.x = 0;
         _tipbackgound.addChild(_tipDis);
         PositionUtils.setPos(_ranking,"bombgame.bomb.rankII.pos");
         PositionUtils.setPos(_nameTxt,"bombgame.bomb.nameII.pos");
         PositionUtils.setPos(_scoreTxt,"bombgame.bomb.scoreII.pos");
         _nameTxt.text = "";
         _scoreTxt.text = "";
         addChild(_ranking);
         addChild(_nameTxt);
         addChild(_scoreTxt);
         addChild(_tipbackgound);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(e:MouseEvent) : void
      {
         if(_info)
         {
            _tipbackgound.visible = true;
            _tipDis.visible = true;
         }
      }
      
      private function __outHandler(e:MouseEvent) : void
      {
         if(_info)
         {
            _tipbackgound.visible = false;
            _tipDis.visible = false;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      public function setRank(value:int) : void
      {
         _rank = value;
         _ranking.text = "" + _rank;
         switch(int(_rank) - 1)
         {
            case 0:
               var _loc2_:* = "bombgame.bomb.rank1TF";
               _ranking.textFormatStyle = _loc2_;
               _loc2_ = _loc2_;
               _nameTxt.textFormatStyle = _loc2_;
               _scoreTxt.textFormatStyle = _loc2_;
               _loc2_ = "bombgame.bomb.rank1GF";
               _ranking.filterString = _loc2_;
               _loc2_ = _loc2_;
               _nameTxt.filterString = _loc2_;
               _scoreTxt.filterString = _loc2_;
               break;
            case 1:
               _loc2_ = "bombgame.bomb.rank2TF";
               _ranking.textFormatStyle = _loc2_;
               _loc2_ = _loc2_;
               _nameTxt.textFormatStyle = _loc2_;
               _scoreTxt.textFormatStyle = _loc2_;
               _loc2_ = "bombgame.bomb.rank2GF";
               _ranking.filterString = _loc2_;
               _loc2_ = _loc2_;
               _nameTxt.filterString = _loc2_;
               _scoreTxt.filterString = _loc2_;
               break;
            case 2:
               _loc2_ = "bombgame.bomb.rank3TF";
               _ranking.textFormatStyle = _loc2_;
               _loc2_ = _loc2_;
               _nameTxt.textFormatStyle = _loc2_;
               _scoreTxt.textFormatStyle = _loc2_;
               _loc2_ = "bombgame.bomb.rank3GF";
               _ranking.filterString = _loc2_;
               _loc2_ = _loc2_;
               _nameTxt.filterString = _loc2_;
               _scoreTxt.filterString = _loc2_;
         }
      }
      
      public function set Info(info:BombRankInfo) : void
      {
         _info = info;
         setRank(_info.rank);
         _nameDis = _info.nameDis;
         _tipDis.text = _info.regDis + "-" + _info.nameDis;
         if(_tipDis.text.length > 14)
         {
            _tipDis.text = _tipDis.text.substr(0,13) + "...";
         }
         if(_nameDis.length > 8)
         {
            _nameDis = _nameDis.substr(0,8).toString() + "..";
         }
         _nameTxt.text = _nameDis;
         _scoreTxt.text = _info.score + "";
      }
      
      public function clear() : void
      {
         _info = null;
         _nameTxt.text = "";
         _scoreTxt.text = "";
         _ranking.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
