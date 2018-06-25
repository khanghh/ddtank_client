package happyLittleGame.bombshellGame.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   
   public class BombRankItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _outPosTxt:FilterFrameText;
      
      private var _rank:int;
      
      private var _info:BombRankInfo;
      
      private var _nameDis:String;
      
      private var _tipbackgound:Image;
      
      private var _tipDis:FilterFrameText;
      
      public function BombRankItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _tipbackgound.width = 250;
         _tipbackgound.height = 30;
         _tipbackgound.y = -30;
         _tipbackgound.x = 50;
         _tipbackgound.visible = false;
         _tipDis = getComponentByStylename("bombgame.rank.name");
         _tipDis.width = 250;
         _tipDis.visible = false;
         _tipDis.x = 0;
         _tipbackgound.addChild(_tipDis);
         _icon = getComponentByStylename("bombgame.Rank.Top3Icon");
         _icon.visible = false;
         _rankTxt = getComponentByStylename("bombgame.rank.ranking");
         _nameTxt = getComponentByStylename("bombgame.rank.name");
         _nameTxt.text = "";
         _scoreTxt = getComponentByStylename("bombgame.rank.score");
         _scoreTxt.text = "";
         _outPosTxt = getComponentByStylename("bombgame.rank.outPos");
         _outPosTxt.text = "";
         addChild(_icon);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_scoreTxt);
         addChild(_outPosTxt);
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
      
      public function set Info(info:BombRankInfo) : void
      {
         _info = info;
         setRank(_info.rank);
         _nameDis = _info.nameDis;
         _tipDis.text = _info.regDis + "-" + _info.nameDis;
         if(_tipDis.length > 15)
         {
            _tipDis.text = _tipDis.text.substr(0,15) + "...";
         }
         if(_nameDis.length > 8)
         {
            _nameDis = _nameDis.substr(0,8).toString() + "..";
         }
         _nameTxt.text = _nameDis;
         _scoreTxt.text = _info.score + "";
         _outPosTxt.text = _info.lvNum + "";
      }
      
      public function clear() : void
      {
         _info = null;
         _nameTxt.text = "";
         _scoreTxt.text = "";
         _outPosTxt.text = "";
         _icon.visible = false;
         _rankTxt.text = "";
      }
      
      public function setRank(ranking:int) : void
      {
         _rank = ranking;
         if(_rank <= 3)
         {
            _icon.setFrame(_rank);
            _icon.visible = true;
         }
         else
         {
            _icon.visible = false;
            _rankTxt.text = ranking + "";
         }
      }
      
      private function getComponentByStylename(stylename:String) : *
      {
         return ComponentFactory.Instance.creatComponentByStylename(stylename);
      }
      
      public function dispose() : void
      {
         var obj:* = null;
         removeEvent();
         while(this.numChildren > 0)
         {
            obj = removeChildAt(0);
            ObjectUtils.disposeObject(obj);
            obj = null;
         }
      }
   }
}
