import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgService {
  final BaseCacheManager _cacheManager = DefaultCacheManager();

  Future<Widget> loadCachedSvg(String url) async {
    try {
      if (url.isEmpty) {
        url =
            'https://storage.googleapis.com/appparcial-123.appspot.com/categories_icons/default.svg';
      }

      final fromCache = await _cacheManager.getFileFromCache(url);

      if (fromCache != null) {
        final Uint8List bytes =
            await fromCache.file.readAsBytes(); // Read bytes
        return SvgPicture.memory(
          bytes,
          fit: BoxFit.fill,
        ); // Use SvgPicture.memory
      } else {
        if (url.startsWith('assets/')) {
          // Asset SVG
          try {
            return SvgPicture.asset(url, fit: BoxFit.fill);
          } catch (e) {
            debugPrint("e === $e");
            url =
                'https://storage.googleapis.com/appparcial-123.appspot.com/categories_icons/default.svg';
            rethrow;
          }
        } else if (url.startsWith('http')) {
          final file = await _cacheManager.downloadFile(url);

          final Uint8List bytes = await file.file.readAsBytes(); // Read bytes
          return SvgPicture.memory(
            bytes,
            fit: BoxFit.fill,
          ); // Use SvgPicture.memory
        } else {
          // Fallback: Use network if not from assets. Handle as needed.
          return SvgPicture.network(url, fit: BoxFit.fill);
        }
      }
    } catch (e) {
      debugPrint("Error loading cached SVG: $e");
      return SvgPicture.network(url, fit: BoxFit.fill);
    }
  }

  Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }

  Future<void> removeFileCache(String url) async {
    await _cacheManager.removeFile(url);
  }
}

final svgServiceProvider = Provider<SvgService>((ref) => SvgService());
